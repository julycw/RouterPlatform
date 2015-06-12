package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Web struct {
	Id           int64     `json:"id"`
	UserId       int64     `json:"uid"`
	Alias        string    `json:"alias" form:"alias"`
	Title        string    `json:"title" form:"title"`
	Address      string    `json:"address" form:"address"`
	ContactName  string    `json:"contact_name" form:"contact_name"`
	ContactPhone string    `json:"contact_phone" form:"contact_phone"`
	Email        string    `json:"email" form:"email"`
	Qq           string    `json:"qq" form:"qq"`
	Description  string    `json:"desc" form:"desc"`
	TplId        int64     `json:"tid" form:"tpl"`
	Click        int       `json:"click"`
	CreateOn     time.Time `json:"create_on"`
	ModifyOn     time.Time `json:"modify_on"`

	TplName    string `json:"-" orm:"-"`
	IfSelected string `json:"-" orm:"-"`
}

func ClickWeb(id int64) {
	GetOrm().Raw("UPDATE web SET click = click+1 WHERE id = ?", id).Exec()
}

func AddWeb(obj Web) (int64, error) {
	obj.CreateOn = time.Now()
	obj.ModifyOn = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return -1, err
	}
	return id, nil
}

func UpdateWeb(id int64, update *Web) (*Web, error) {
	if obj, err := GetWeb(id); err == nil {
		if update.Title != "" {
			obj.Title = update.Title
		}
		if update.Alias != "" {
			obj.Alias = update.Alias
		}
		if update.UserId != 0 {
			obj.UserId = update.UserId
		}
		if update.TplId != -1 {
			obj.TplId = update.TplId
		}
		// if update.Address != "" {
		obj.Address = update.Address
		// }
		// if update.ContactName != "" {
		obj.ContactName = update.ContactName
		// }
		// if update.ContactPhone != "" {
		obj.ContactPhone = update.ContactPhone
		// }
		// if update.Email != "" {
		obj.Email = update.Email
		// }
		// if update.Qq != "" {
		obj.Qq = update.Qq
		// }
		// if update.Description != "" {
		obj.Description = update.Description
		// }
		obj.ModifyOn = time.Now()

		o := GetOrm()
		_, err := o.Update(obj)
		if err != nil {
			return nil, err
		}
		return obj, nil
	} else {
		return nil, err
	}
}

func GetWeb(id int64) (*Web, error) {
	o := GetOrm()
	web := new(Web)
	if err := o.QueryTable("web").Filter("Id", id).RelatedSel().One(web); err != nil {
		return nil, err
	}

	return web, nil
}

func GetAllWebs(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Web, int64, error) {
	o := GetOrm()
	var webs *[]Web = new([]Web)
	total, err := o.QueryTable("web").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("web").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(webs)
	if err != nil {
		return nil, 0, err
	}
	return webs, total, nil
}

func DeleteWeb(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("web").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
