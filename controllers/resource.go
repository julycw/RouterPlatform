package controllers

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/models"
	"strconv"
	"strings"
)

type ResourceController struct {
	BaseController
}

func (this *ResourceController) Get() {
	id, _ := this.GetInt64(":id")
	if resource, err := models.GetResource(id); err == nil {
		this.Data["json"] = map[string]interface{}{
			"code": 0,
			"data": resource,
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code":  1,
			"msg":   "获取该模板数据失败，该模板可能已删除",
			"error": err.Error(),
		}
	}
	this.ServeJson()
}

func (this *ResourceController) Manage() {
	cond := orm.NewCondition()
	cond2 := cond.And("UserId", this.userid)
	totalSize := 0
	if resources, _, err := models.GetAllResources(cond2, 1, 1000); err == nil {
		for i, v := range *resources {
			totalSize += v.Size
			switch v.Type {
			case int(models.ResourceTypeImage):
				(*resources)[i].DisplayTag = `<img src="` + v.Path + `" width="50" height="50"/>`
			default:
				(*resources)[i].DisplayTag = `<span class="glyphicon glyphicon-question-sign" aria-hidden="true" style="width:50px;font-size:18px;text-align:center;"></span>`
			}
		}
		this.Data["percent"] = totalSize * 100 / (1024 * 1024 * 20)
		this.Data["totalSize"] = totalSize
		this.Data["resources"] = resources
	}
	this.TplNames = "resource.tpl"
}

func (this *ResourceController) AddResource() {
	var resource models.Resource
	if err := this.ParseForm(&resource); err != nil {
		this.Log(models.LogError, err.Error())
		this.ShowMessageNextPage("输入信息不正确", "danger")
	} else {
		if file, fileHeader, err := this.GetFile("file"); err == nil {
			defer file.Close()
			// 文件类型判断
			dotIndex := strings.Index(fileHeader.Filename, ".")
			if dotIndex == -1 {
				this.ShowMessageNextPage("禁止上传该类型的文件", "danger")
			} else {
				ext := strings.ToLower(fileHeader.Filename[dotIndex:])
				switch ext {
				case ".png", ".jpg", ".jpeg", ".gif", ".bmp":
					resource.Type = int(models.ResourceTypeImage)
				case ".txt", ".md", ".log", ".doc", ".json", ".xml":
					resource.Type = int(models.ResourceTypeText)
				case ".mp4", ".mp3", ".flv", ".avi", ".wav", ".swf":
					resource.Type = int(models.ResourceTypeMedia)
				case ".bat", ".exe":
					this.ShowMessageNextPage("禁止上传该类型的文件", "danger")
					this.Redirect("/manage/resource", 302)
					this.StopRun()
				default:
					resource.Type = int(models.ResourceTypeOhter)
				}

				resource.UserId = this.userid
				resource.FileName = fileHeader.Filename

				resourcePath := beego.AppConfig.String("resourcepath")
				if resourcePath == "" {
					this.ShowMessageNextPage("系统异常，请联系管理员", "danger")
				} else {
					var maxSize int
					var currSize int
					// 获取当前已使用的空间大小
					o := models.GetOrm()
					var maps []orm.Params
					if lines, _ := o.Raw("select sum(size) as currSize from resource where user_id = ?", this.userid).Values(&maps); lines > 0 {
						if maps[0]["currSize"] != nil {
							currSize, _ = strconv.Atoi(maps[0]["currSize"].(string))
						}
					}
					// 获取最大允许使用大小
					option, err := models.GetUserOption(this.userid)
					if err == nil {
						maxSize = option.MaxResourceSize
					} else {
						maxSize = models.OptionMaxResourceSize()
					}

					var fileSize int
					buffer := make([]byte, 1024)
					hash := md5.New()
					for {
						if l, err := file.Read(buffer); err == nil {
							fileSize += l
							hash.Write(buffer)
							if currSize+fileSize > maxSize {
								this.ShowMessageNextPage("您的空间已不足", "danger")
								this.Redirect("/manage/resource", 302)
								this.StopRun()
							}
						} else {
							break
						}
					}
					resource.Size = fileSize
					resource.Md5 = hex.EncodeToString(hash.Sum(nil))

					if lines, err := o.Raw("select path from resource where md5 = ?", resource.Md5).Values(&maps); lines > 0 && err == nil {
						resource.Path = maps[0]["path"].(string)
					} else {
						if err := this.SaveToFile("file", fmt.Sprintf("%s/%s%s", resourcePath, resource.Md5, ext)); err == nil {
							resource.Path = fmt.Sprintf("/static/resource/%s%s", resource.Md5, ext)
						} else {
							this.ShowMessageNextPage("文件上传失败，请联系管理员", "danger")
							this.Redirect("/manage/resource", 302)
							this.StopRun()
						}
					}

					if _, err := models.AddResource(resource); err != nil {
						this.Log(models.LogError, err.Error())
						this.ShowMessageNextPage("系统异常，请联系管理员", "danger")
					} else {
						this.ShowMessageNextPage("上传成功", "success")
					}
				}
			}
		} else {
			this.ShowMessageNextPage("必须附带上传资源文件", "danger")
		}
	}
	this.Redirect("/manage/resource", 302)
}

func (this *ResourceController) UpdateResource() {
	id, _ := this.GetInt64(":id")
	if id != 0 {
		var resource models.Resource
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &resource); err != nil {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "输入信息不正确",
				"err":  err.Error(),
			}
		} else {
			update, err := models.UpdateResource(id, &resource)
			if err != nil {
				this.Data["json"] = map[string]interface{}{
					"code": 1,
					"msg":  "系统异常，请联系管理员",
					"err":  err.Error(),
				}
			} else {
				this.Data["json"] = map[string]interface{}{
					"code": 0,
					"data": update,
				}
			}
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "数据异常，请联系管理员",
		}
	}
	this.ServeJson()
}

func (this *ResourceController) DeleteResource() {
	id, _ := this.GetInt64(":id")

	if err := models.DeleteResource(id); err != nil {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "系统异常，请联系管理员",
			"err":  err.Error(),
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code": 0,
		}
	}

	this.ServeJson()
}
