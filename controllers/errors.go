package controllers

type ErrorController struct {
	BaseController
}

func (this *ErrorController) Prepare() {

}

func (this *ErrorController) Error404() {
	this.TplNames = "errors/404.tpl"
}

func (this *ErrorController) Test() {
	this.TplNames = "test/test.tpl"
}
