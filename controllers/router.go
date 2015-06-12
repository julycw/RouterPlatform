package controllers

import (
	// "github.com/astaxie/beego"
	"encoding/json"
	"github.com/julycw/RouterPlatform/models"
)

type RouterController struct {
	BaseController
}

func (this *RouterController) AddRouter() {
	var router models.Router
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &router)
	if err != nil {
		this.Data["json"] = map[string]interface{}{
			"code":    1,
			"msg":     "输入信息不正确",
			"err":     err.Error(),
			"request": string(this.Ctx.Input.RequestBody),
		}
	} else {
		if router.Alias == "" {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "别名不能为空",
			}
		} else {
			router.UserId = this.userid
			if id, err := models.AddRouter(router); err != nil {
				this.Data["json"] = map[string]interface{}{
					"code": 1,
					"msg":  "系统异常，请联系管理员",
					"err":  err.Error(),
				}
			} else {
				this.Data["json"] = map[string]interface{}{
					"code": 0,
					"data": id,
				}
			}
		}
	}
	this.ServeJson()
}

func (this *RouterController) UpdateRouter() {
	id, _ := this.GetInt64(":id")
	var router models.Router
	if err := json.Unmarshal(this.Ctx.Input.RequestBody, &router); err != nil {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "输入信息不正确",
			"err":  err.Error(),
		}
	} else {
		if update, err := models.UpdateRouter(id, &router); err != nil {
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
	this.ServeJson()
}

func (this *RouterController) DeleteRouter() {
	id, _ := this.GetInt64(":id")
	if err := models.DeleteRouter(id); err != nil {
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
