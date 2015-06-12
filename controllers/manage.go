package controllers

import (
	// "github.com/astaxie/beego"
	"fmt"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/models"
)

type ManageController struct {
	BaseController
}

func (this *ManageController) Get() {
	router_alias := this.GetString(":alias")

	cond := orm.NewCondition()
	cond2 := cond.And("UserId", this.userid)

	// routers
	if routers, total, err := models.GetAllRouters(cond2, 1, 10); err == nil {
		var webId int64
		if len(*routers) > 0 {
			if router_alias != "" {
				for i, v := range *routers {
					if v.Alias == router_alias {
						webId = v.WebId
						this.Data["router"] = v
						(*routers)[i].IfSelected = "selected"
						break
					}
				}
				if webId == 0 {
					(*routers)[0].IfSelected = "selected"
					webId = (*routers)[0].WebId
					this.Data["router"] = (*routers)[0]
				}
			} else {
				(*routers)[0].IfSelected = "selected"
				webId = (*routers)[0].WebId
				this.Data["router"] = (*routers)[0]
			}

			web, err := models.GetWeb(webId)
			if err == nil {
				this.Data["web"] = web
			} else {
				this.Log(models.LogError, err.Error())
			}

			cond3 := cond2.And("WebId", webId)
			articles, articlesTotal, err := models.GetAllArticles(cond3, 1, 40, "order")
			if err == nil {
				if articlesTotal > 0 {
					for i, v := range *articles {
						if v.Visible == int(models.Visible) {
							(*articles)[i].VisibleStr = "可见"
						} else {
							(*articles)[i].VisibleStr = "隐藏"
						}
					}
					this.Data["articles"] = articles
				}
			} else {
				this.Log(models.LogError, err.Error())
			}

			if tpls, _, err := models.GetAllTpls(cond2, 1, 20); err == nil {
				webTpls := make([]models.Tpl, 0)
				articleTpls := make([]models.Tpl, 0)
				for _, v := range *tpls {
					if v.Type == int(models.TplTypeWeb) {
						if web.TplId == v.Id {
							v.IfSelected = "selected"
						}
						webTpls = append(webTpls, v)
					} else {
						articleTpls = append(articleTpls, v)
					}
				}
				this.Data["webTpls"] = &webTpls
				this.Data["articleTpls"] = &articleTpls
			} else {
				this.Log(models.LogError, err.Error())
			}
			this.Data["routers"] = routers
			this.Data["routers_total"] = total
		}
	} else {
		this.Log(models.LogError, err.Error())
	}

	// webs
	if this.Data["router"] != nil {
		if webs, _, err := models.GetAllWebs(cond2, 1, 10); err == nil {
			for i, v := range *webs {
				if v.Id == this.Data["router"].(models.Router).WebId {
					(*webs)[i].IfSelected = "selected"
					break
				}
			}
			this.Data["webs"] = webs
		} else {
			this.Log(models.LogError, err.Error())
		}
	}
	this.TplNames = "manage.tpl"
}

func (this *ManageController) ViewTpl() {
	id, _ := this.GetInt64(":id")
	tpl, err := models.GetTpl(id)
	if err != nil {
		this.Redirect("/errors/404", 302)
	} else {
		switch tpl.Type {
		case int(models.TplTypeWeb):
			this.Data["web"] = &models.Web{}
			this.Data["articles"] = &[]models.Article{}
		case int(models.TplTypeArticle):
			this.Data["article"] = &models.Article{}
		}
		this.TplNames = fmt.Sprintf("user_tpls/%d/%s", this.userid, tpl.File)
	}
}
