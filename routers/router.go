package routers

import (
	"github.com/astaxie/beego"
	"github.com/julycw/RouterPlatform/controllers"
)

func init() {
	beego.Router("/", &controllers.IndexController{})

	beego.Router("/i/:alias", &controllers.DisplayController{}, "get:ShowWeb")
	beego.Router("/i/article/:id", &controllers.DisplayController{}, "get:ShowArticle")
	beego.Router("/i/tpl/:id", &controllers.DisplayController{}, "get:ShowTpl")

	beego.Router("/manage/", &controllers.ManageController{})
	beego.Router("/manage/:alias", &controllers.ManageController{})
	beego.Router("/manage/router", &controllers.RouterController{}, "post:AddRouter")
	beego.Router("/manage/router/:id", &controllers.RouterController{}, "put:UpdateRouter")
	beego.Router("/manage/router/:id", &controllers.RouterController{}, "delete:DeleteRouter")
	beego.Router("/manage/web", &controllers.WebController{}, "get:Manage")
	beego.Router("/manage/web", &controllers.WebController{}, "post:AddWeb")
	beego.Router("/manage/web/:id", &controllers.WebController{}, "put:UpdateWeb")
	beego.Router("/manage/web/:id", &controllers.WebController{}, "delete:DeleteWeb")
	beego.Router("/manage/article", &controllers.ArticleController{}, "post:AddArticle")
	beego.Router("/manage/article/:id", &controllers.ArticleController{}, "put:UpdateArticle")
	beego.Router("/manage/article/:id", &controllers.ArticleController{}, "delete:DeleteArticle")
	beego.Router("/manage/tpl/", &controllers.TplController{}, "get:Manage")
	beego.Router("/manage/tpl/", &controllers.TplController{}, "post:AddTpl")
	beego.Router("/manage/tpl/:id", &controllers.TplController{}, "put:UpdateTpl")
	beego.Router("/manage/tpl/:id", &controllers.TplController{}, "delete:DeleteTpl")
	beego.Router("/manage/resource/", &controllers.ResourceController{}, "get:Manage")
	beego.Router("/manage/resource/", &controllers.ResourceController{}, "post:AddResource")
	beego.Router("/manage/resource/:id", &controllers.ResourceController{}, "put:UpdateResource")
	beego.Router("/manage/resource/:id", &controllers.ResourceController{}, "delete:DeleteResource")
	beego.Router("/manage/feedback", &controllers.FeedbackController{}, "post:AddFeedback")

	beego.Router("/web/:id", &controllers.WebController{}, "get:Get")
	beego.Router("/tpl/:id", &controllers.TplController{}, "get:Get")
	beego.Router("/article/:id", &controllers.ArticleController{}, "get:Get")
	beego.Router("/resource/:id", &controllers.ResourceController{}, "get:Get")

	beego.Router("/auth/register", &controllers.AuthController{}, "post:Register")
	beego.Router("/auth/changePassword", &controllers.AuthController{}, "post:ChangePassword")
	beego.Router("/auth/login", &controllers.AuthController{}, "get:LoginPage")
	beego.Router("/auth/login", &controllers.AuthController{}, "post:Login")
	beego.Router("/auth/logout", &controllers.AuthController{}, "get:Logout")
	beego.Router("/auth/verify", &controllers.AuthController{}, "get:VerifyImage")

	beego.Router("/errors/404", &controllers.ErrorController{}, "get:Error404")

	beego.Router("/test", &controllers.ErrorController{}, "get:Test")

}
