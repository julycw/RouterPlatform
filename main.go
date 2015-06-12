package main

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"github.com/julycw/RouterPlatform/models"
	_ "github.com/julycw/RouterPlatform/routers"
	"github.com/julycw/RouterPlatform/viewfunc"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	// beego.TemplateLeft = "<<<"
	// beego.TemplateRight = ">>>"

	beego.InsertFilter("*", beego.BeforeRouter, func(ctx *context.Context) {
		ctx.Output.Header("Access-Control-Allow-Origin", "*")
	})

	beego.SessionOn = true
	beego.Run()
}

func init() {
	file, _ := exec.LookPath(os.Args[0])
	path, _ := filepath.Abs(file)
	index := strings.LastIndex(path, "\\")

	tplPath := path[:index] + "\\" + beego.ViewsPath + "\\user_tpls"
	if fi, err := os.Stat(tplPath); err != nil || !fi.IsDir() {
		os.Mkdir(tplPath, os.ModePerm)
	}
	if err := beego.AppConfig.Set("tplpath", tplPath); err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println("Use tpl path: ", tplPath)
		beego.AppConfig.SaveConfigFile("conf\\app.conf")
	}

	resourcePath := path[:index] + "\\static\\resource"
	if fi, err := os.Stat(resourcePath); err != nil || !fi.IsDir() {
		os.Mkdir(resourcePath, os.ModePerm)
	}
	if err := beego.AppConfig.Set("resourcepath", resourcePath); err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println("Use resource path: ", resourcePath)
		beego.AppConfig.SaveConfigFile("conf\\app.conf")
	}

	// 系统设置初始化
	models.SetOptionMaxRouterNum(3)
	models.SetOptionMaxWebNum(5)
	models.SetOptionMaxTplNum(20)
	models.SetOptionMaxResourceSize(20 * 1024 * 1024)

	beego.AddFuncMap("TplTypeName", models.TplTypeName)
	beego.AddFuncMap("ResourceTypeName", models.ResourceTypeName)
	beego.AddFuncMap("FormatFileSize", viewfunc.FormatFileSize)

	// beego.BuildTemplate("views")
}
