package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/julycw/RouterPlatform/models"
	"log"
	"time"
)

type BaseController struct {
	beego.Controller
	username string
	userid   int64
}

func (this *BaseController) Prepare() {
	if this.GetSession("username") == nil || this.GetSession("userid") == nil {
		if this.IsAjax() {
			this.Data["json"] = map[string]interface{}{
				"code": 99,
				"msg":  "认证已过期，请重新登陆",
			}
			this.ServeJson()
		} else {
			this.Redirect("/auth/login", 302)
		}
		this.StopRun()
	} else {
		this.username = this.GetSession("username").(string)
		this.userid = this.GetSession("userid").(int64)
		// `
		// <div class="alert alert-success" role="alert">...</div>
		// <div class="alert alert-info" role="alert">...</div>
		// <div class="alert alert-warning" role="alert">...</div>
		// <div class="alert alert-danger" role="alert">...</div>
		// `
		if msg := this.GetSession("messageContent"); msg != nil {
			this.Data["PageMessage"] = fmt.Sprintf(`<div class="alert alert-%s alert-dismissible fade in" style="margin-bottom:0px;" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button><p style="text-align:center;">%s</p></div>
		    `, this.GetSession("messageCategory"), msg)
			this.DelSession("messageContent")
			this.DelSession("messageCategory")
		}
	}
}

func (this *BaseController) Log(category models.LogCategory, content string) {
	log.Println(content)
	if _, err := models.AddLog(models.Log{
		UserId:   this.userid,
		Content:  content,
		Category: int(category),
		Time:     time.Now(),
	}); err != nil {
		log.Println(err.Error())
	}
}

func (this *BaseController) ShowMessageNextPage(message string, cate ...string) {
	this.SetSession("messageContent", message)
	var category string
	if len(cate) == 0 {
		category = "info"
	} else {
		category = cate[0]
	}
	this.SetSession("messageCategory", category)
}
