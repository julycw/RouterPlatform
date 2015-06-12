package controllers

import (
	// "github.com/astaxie/beego"
	"encoding/json"
	"github.com/julycw/RouterPlatform/models"
)

type FeedbackController struct {
	BaseController
}

func (this *FeedbackController) Prepare() {
	if this.GetSession("username") != nil && this.GetSession("userid") != nil {
		this.username = this.GetSession("username").(string)
		this.userid = this.GetSession("userid").(int64)
	}
}

func (this *FeedbackController) AddFeedback() {
	var feedback models.Feedback
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &feedback)
	if err != nil {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "输入信息不正确",
			"err":  err.Error(),
		}
	} else {
		if feedback.Content == "" {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "内容不能为空",
			}
		} else {
			feedback.UserId = this.userid
			if id, err := models.AddFeedback(feedback); err != nil {
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
