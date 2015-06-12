package controllers

import (
	// "bytes"
	"github.com/dchest/captcha"
	"github.com/julycw/RouterPlatform/models"
	"github.com/julycw/RouterPlatform/tools"
	"time"
)

type AuthController struct {
	BaseController
}

func (this *AuthController) Prepare() {
	// do nothing
}

func (this *AuthController) VerifyImage() {
	this.Ctx.ResponseWriter.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	this.Ctx.ResponseWriter.Header().Set("Pragma", "no-cache")
	this.Ctx.ResponseWriter.Header().Set("Expires", "0")
	this.Ctx.ResponseWriter.Header().Set("Content-Type", "image/png")
	verifyId := captcha.NewLen(4)
	this.SetSession("verifyId", verifyId)
	captcha.WriteImage(this.Ctx.ResponseWriter, verifyId, 120, 55)
}

func (this *AuthController) LoginPage() {
	this.TplNames = "login.tpl"
}

func (this *AuthController) Login() {
	username := this.GetString("username")
	password := this.GetString("password")
	verify := this.GetString("verify")
	verify_id := this.GetSession("verifyId")
	if verify_id != nil && captcha.VerifyString(verify_id.(string), verify) {
		o := models.GetOrm()
		user := models.User{}
		if err := o.QueryTable("user").Filter("username", username).One(&user); err == nil {
			if user.Password == tools.MD5(password) {
				// 设置session
				this.SetSession("username", username)
				this.SetSession("userid", user.Id)
				//更新用户登录时间
				user.LastLoginOn = time.Now()
				if _, err := models.UpdateUser(user.Id, &user); err != nil {
					this.Log(models.LogError, err.Error())
				}

				this.Data["json"] = map[string]interface{}{
					"code": 0,
				}
			} else {
				this.Data["json"] = map[string]interface{}{
					"code": 1,
					"msg":  "密码错误",
				}
			}
		} else {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "用户名错误",
			}
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "验证码错误",
		}
	}

	this.ServeJson()
}

func (this *AuthController) Logout() {
	if this.GetSession("userid") != nil {
		this.DelSession("userid")
	}

	if this.GetSession("username") != nil {
		this.DelSession("username")
	}

	this.Redirect("/", 302)
}

func (this *AuthController) Register() {
	username := this.GetString("username")
	password := this.GetString("password")
	verify := this.GetString("verify")
	if verify == "16me.cn" {
		user := models.User{
			UserName: username,
			Password: tools.MD5(password),
			Status:   1,
		}
		if id, err := models.AddUser(user); err == nil {
			// 设置session
			this.SetSession("username", username)
			this.SetSession("userid", id)
			//更新用户登录时间
			user.LastLoginOn = time.Now()
			models.UpdateUser(id, &user)
			//
			this.Data["json"] = map[string]interface{}{
				"code": 0,
			}
		} else {
			this.Data["json"] = map[string]interface{}{
				"code": 1,
				"msg":  "输入信息不正确",
			}
		}
	} else {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "验证码错误",
		}
	}
	this.ServeJson()
}

func (this *AuthController) ChangePassword() {
	if this.GetSession("username") == nil || this.GetSession("userid") == nil {
		this.Data["json"] = map[string]interface{}{
			"code": 1,
			"msg":  "认证已过期，请重新登陆",
		}
	} else {
		o := models.GetOrm()
		var user models.User
		password := this.GetString("password")
		new_password := this.GetString("new_password")
		userid := this.GetSession("userid").(int64)
		if err := o.QueryTable("user").Filter("id", userid).One(&user); err == nil {
			if user.Password == tools.MD5(password) {
				//更新用户登录时间
				user.Password = tools.MD5(new_password)
				models.UpdateUser(userid, &user)
				//
				this.Data["json"] = map[string]interface{}{
					"code": 0,
				}
			} else {
				this.Data["json"] = map[string]interface{}{
					"code":     1,
					"msg":      "密码错误",
					"password": user.Password,
				}
			}
		}
	}
	this.ServeJson()
}
