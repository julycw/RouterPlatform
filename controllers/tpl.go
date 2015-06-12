package controllers

import (
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/models"
	"os"
	"time"
)

type TplController struct {
	BaseController
}

func (this *TplController) Get() {
	id, _ := this.GetInt64(":id")
	if tpl, err := models.GetTpl(id); err == nil {
		this.Data["json"] = map[string]interface{}{
			"code": 0,
			"data": tpl,
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

func (this *TplController) Manage() {
	cond := orm.NewCondition()
	cond2 := cond.And("UserId", this.userid)
	if tpls, total, err := models.GetAllTpls(cond2, 1, 50); err == nil {
		this.Data["total"] = total
		this.Data["tpls"] = tpls
	}
	this.TplNames = "template.tpl"
}

func (this *TplController) AddTpl() {
	var tpl models.Tpl
	if err := this.ParseForm(&tpl); err != nil {
		this.Log(models.LogError, err.Error())
		this.ShowMessageNextPage("输入信息不正确", "danger")
	} else {

		if tpl.Name == "" {
			this.ShowMessageNextPage("标题不能为空", "danger")
		} else {
			if _, _, err := this.GetFile("file"); err == nil {
				tplPath := beego.AppConfig.String("tplpath")
				if tplPath == "" {
					this.ShowMessageNextPage("系统异常，请联系管理员", "danger")
				} else {
					path := fmt.Sprintf("%s\\%d\\", tplPath, this.userid)
					fileName := fmt.Sprintf("%d.tpl", time.Now().Unix())

					if fi, err := os.Stat(path); err != nil {
						os.Mkdir(path, os.ModePerm)
					} else {
						if !fi.IsDir() {
							os.Mkdir(path, os.ModePerm)
						}
					}

					if err := this.SaveToFile("file", path+fileName); err != nil {
						this.Log(models.LogError, err.Error())
						this.ShowMessageNextPage("文件上传失败，请联系管理员", "danger")
					} else {
						this.Log(models.LogDebug, "保存模板文件到: "+path+fileName)
						tpl.File = fileName
						tpl.UserId = this.userid
						if _, err := models.AddTpl(tpl); err != nil {
							this.Log(models.LogError, err.Error())
							this.ShowMessageNextPage("系统异常，请联系管理员", "danger")
						} else {
							this.ShowMessageNextPage("上传成功", "success")
						}
					}
				}
			} else {
				this.ShowMessageNextPage("必须附带上传模板文件", "danger")
			}
		}
	}

	this.Redirect("/manage/tpl", 302)
}

func (this *TplController) UpdateTpl() {
	id, _ := this.GetInt64(":id")
	if id != 0 {
		var tpl models.Tpl
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &tpl); err != nil {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "输入信息不正确",
				"err":  err.Error(),
			}
		} else {
			update, err := models.UpdateTpl(id, &tpl)
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

func (this *TplController) DeleteTpl() {
	id, _ := this.GetInt64(":id")

	cond := orm.NewCondition()
	cond1 := cond.And("UserId", this.userid).And("TplId", id)

	_, total1, _ := models.GetAllWebs(cond1, 1, 0)
	_, total2, _ := models.GetAllArticles(cond1, 1, 0)
	if total1 > 0 || total2 > 0 {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "该站定正在使用中，无法删除",
		}
	} else {
		if err := models.DeleteTpl(id); err != nil {
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
	}

	this.ServeJson()
}
