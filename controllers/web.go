package controllers

import (
	// "github.com/astaxie/beego"
	"encoding/json"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/models"
)

type WebController struct {
	BaseController
}

func (this *WebController) Get() {
	id, _ := this.GetInt64(":id")
	if web, err := models.GetWeb(id); err == nil {
		this.Data["json"] = map[string]interface{}{
			"code": 0,
			"data": web,
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code":  1,
			"msg":   "获取该站点数据失败，该模板可能已删除",
			"error": err.Error(),
		}
	}
	this.ServeJson()
}

func (this *WebController) Manage() {
	cond := orm.NewCondition()
	cond2 := cond.And("UserId", this.userid)
	webs, total, err1 := models.GetAllWebs(cond2, 1, 50)
	if err1 != nil {
		this.Log(models.LogError, err1.Error())
	}

	// 获取模板列表
	cond3 := cond2.And("Type", models.TplTypeWeb)
	tpls, _, err2 := models.GetAllTpls(cond3, 1, 50)
	if err2 != nil {
		this.Log(models.LogError, err2.Error())
	}

	for i, web := range *webs {
		if web.TplId == 0 {
			(*webs)[i].TplName = "默认"
		} else {
			for _, tpl := range *tpls {
				if web.TplId == tpl.Id {
					(*webs)[i].TplName = tpl.Name
					break
				}
			}
		}
	}

	this.Data["webs"] = webs
	this.Data["total"] = total
	this.Data["webTpls"] = tpls
	this.TplNames = "web.tpl"
}

func (this *WebController) AddWeb() {
	var web models.Web
	if err := this.ParseForm(&web); err != nil {
		this.Log(models.LogError, err.Error())
		this.ShowMessageNextPage("输入信息不正确", "danger")
	} else {
		if web.Alias == "" {
			this.ShowMessageNextPage("标题不能为空", "danger")
		} else {
			web.UserId = this.userid
			if _, err := models.AddWeb(web); err != nil {
				this.Log(models.LogError, err.Error())
				this.ShowMessageNextPage("系统异常，请联系管理员", "danger")
			} else {
				this.ShowMessageNextPage("添加成功", "success")
			}
		}
	}
	this.Redirect("/manage/web", 302)
}

func (this *WebController) UpdateWeb() {
	id, _ := this.GetInt64(":id")
	if id != 0 {
		var web models.Web
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &web); err != nil {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "输入信息不正确",
				"err":  err.Error(),
			}
		} else {
			update, err := models.UpdateWeb(id, &web)
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

func (this *WebController) DeleteWeb() {
	id, _ := this.GetInt64(":id")

	cond := orm.NewCondition()
	cond1 := cond.And("UserId", this.userid).And("WebId", id)

	if _, total, err := models.GetAllRouters(cond1, 1, 1); err == nil {
		if total > 0 {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "该站定正在使用中，无法删除",
			}
		} else {
			if err := models.DeleteWeb(id); err != nil {
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
	} else {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "系统异常，请联系管理员",
			"err":  err.Error(),
		}
	}

	this.ServeJson()
}
