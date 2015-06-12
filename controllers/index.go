package controllers

import (
// "github.com/astaxie/beego"
)

type IndexController struct {
	BaseController
}

func (c *IndexController) Prepare() {

}

func (c *IndexController) Get() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplNames = "index.tpl"
}
