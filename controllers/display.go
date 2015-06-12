package controllers

import (
	"fmt"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/models"
)

type DisplayController struct {
	BaseController
}

func (this *DisplayController) Prepare() {

}

func (this *DisplayController) ShowWeb() {
	defer func() {
		if err := recover(); err != nil {
			this.Redirect("/errors/404", 302)
		}
	}()
	this.Layout = "layout/web/default.tpl"
	webAlias := this.GetString(":alias")
	cond := orm.NewCondition()
	cond2 := cond.And("Alias", webAlias)
	webs, total, err := models.GetAllWebs(cond2, 1, 1)
	if err != nil || total == 0 {
		this.Redirect("/errors/404", 302)
	} else {
		web := (*webs)[0]
		if web.Address == "" || web.ContactName == "" || web.ContactPhone == "" || web.Email == "" || web.Qq == "" {
			this.Data["lackOfContactInfo"] = "yes"
		}
		models.ClickWeb(web.Id)
		this.Data["web"] = web

		cond3 := cond.And("WebId", web.Id)
		articles, _, _ := models.GetAllArticles(cond3, 1, 100, "order")
		for i, v := range *articles {
			if v.FaceImagePath == "" {
				(*articles)[i].FaceImagePath = "/static/img/article-default.png"
			}
		}
		this.Data["articles"] = articles

		if web.TplId == 0 {
			this.TplNames = "share_tpls/default_web.tpl"
		} else {
			tpl, err := models.GetTpl(web.TplId)
			if err != nil {
				this.Redirect("/errors/404", 302)
			}
			if tpl.Public == 1 {
				this.TplNames = fmt.Sprintf("share_tpls/%s", tpl.File)
			} else {
				this.TplNames = fmt.Sprintf("user_tpls/%d/%s", web.UserId, tpl.File)
			}
		}
	}
}

func (this *DisplayController) ShowArticle() {
	defer func() {
		if err := recover(); err != nil {
			this.Redirect("/errors/404", 302)
		}
	}()
	this.Layout = "layout/article/default.tpl"
	id, _ := this.GetInt64(":id")
	article, err := models.GetArticle(id)
	if err != nil {
		this.Redirect("/errors/404", 302)
	} else {
		web, err := models.GetWeb(article.WebId)
		if err != nil {
			this.Redirect("/errors/404", 302)
		} else {
			this.Data["web"] = web
		}
		models.ClickArticle(article.Id)

		if article.FaceImagePath == "" {
			article.FaceImagePath = "/static/img/article-default.png"
		}

		this.Data["article"] = article
		if article.TplId == 0 {
			this.TplNames = "share_tpls/default_article.tpl"
		} else {
			if tpl, err := models.GetTpl(article.TplId); err != nil {
				this.Redirect("/errors/404", 302)
			} else {
				if tpl.Public == 1 {
					this.TplNames = fmt.Sprintf("share_tpls/%s", tpl.File)
				} else {
					this.TplNames = fmt.Sprintf("user_tpls/%d/%s", article.UserId, tpl.File)
				}
			}
		}
	}
}

func (this *DisplayController) ShowTpl() {
	defer func() {
		if err := recover(); err != nil {
			this.Redirect("/errors/404", 302)
		}
	}()
	id, _ := this.GetInt64(":id")
	tpl, err := models.GetTpl(id)
	if err != nil {
		this.Redirect("/errors/404", 302)
	} else {
		if tpl.Public == 1 {
			this.TplNames = fmt.Sprintf("share_tpls/%s", tpl.File)
		} else {
			this.TplNames = fmt.Sprintf("user_tpls/%d/%s", tpl.UserId, tpl.File)
		}
	}
}
