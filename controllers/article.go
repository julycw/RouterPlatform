package controllers

import (
	// "github.com/astaxie/beego"
	"encoding/json"
	"github.com/julycw/RouterPlatform/models"
)

type ArticleController struct {
	BaseController
}

func (this *ArticleController) Get() {
	id, _ := this.GetInt64(":id")
	if article, err := models.GetArticle(id); err == nil {
		this.Data["json"] = map[string]interface{}{
			"code": 0,
			"data": article,
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code":  1,
			"msg":   "获取该数据失败，可能已删除",
			"error": err.Error(),
		}
	}
	this.ServeJson()
}

func (this *ArticleController) AddArticle() {
	var article models.Article
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &article)
	if err != nil {
		this.Data["json"] = map[string]interface{}{
			"code":    1,
			"msg":     "输入信息不正确",
			"err":     err.Error(),
			"request": string(this.Ctx.Input.RequestBody),
		}
	} else {
		if article.Title == "" {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "标题不能为空",
			}
		} else {
			article.UserId = this.userid
			if id, err := models.AddArticle(article); err != nil {
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

func (this *ArticleController) UpdateArticle() {
	id, _ := this.GetInt64(":id")
	if id != 0 {
		var article models.Article
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &article); err != nil {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "输入信息不正确",
				"err":  err.Error(),
			}
		} else {
			update, err := models.UpdateArticle(id, &article)
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

func (this *ArticleController) DeleteArticle() {
	id, _ := this.GetInt64(":id")
	if err := models.DeleteArticle(id); err != nil {
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
