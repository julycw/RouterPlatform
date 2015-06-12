package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type TplType int

const (
	TplTypeWeb TplType = 1 + iota
	TplTypeArticle
)

type Tpl struct {
	Id          int64     `json:"id"`
	Name        string    `json:"name" form:"name"`
	File        string    `json:"file"`
	UserId      int64     `json:"uid"`
	Type        int       `json:"type" form:"type"`
	Description string    `json:"desc" form:"description"`
	Public      int       `json:"public"`
	CreateOn    time.Time `json:"create_on"`
	ModifyOn    time.Time `json:"modify_on"`

	IfSelected string `json:"-" orm:"-"`
}

func TplTypeName(in int) string {
	switch in {
	case int(TplTypeWeb):
		return "站点模板"
	case int(TplTypeArticle):
		return "产品模板"
	}
	return "未知"
}

func AddTpl(obj Tpl) (int64, error) {
	obj.CreateOn = time.Now()
	obj.ModifyOn = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return -1, err
	}
	return id, nil
}

func UpdateTpl(id int64, update *Tpl) (*Tpl, error) {
	if obj, err := GetTpl(id); err == nil {
		if update.Name != "" {
			obj.Name = update.Name
		}
		if update.File != "" {
			obj.File = update.File
		}
		if update.UserId != 0 {
			obj.UserId = update.UserId
		}
		if update.Type != 0 {
			obj.Type = update.Type
		}
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

func GetTpl(id int64) (*Tpl, error) {
	o := GetOrm()
	tpl := new(Tpl)
	if err := o.QueryTable("tpl").Filter("Id", id).RelatedSel().One(tpl); err != nil {
		return nil, err
	}

	return tpl, nil
}

func GetAllTpls(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Tpl, int64, error) {
	o := GetOrm()
	var tpls *[]Tpl = new([]Tpl)
	total, err := o.QueryTable("tpl").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("tpl").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(tpls)
	if err != nil {
		return nil, 0, err
	}
	return tpls, total, nil
}

func DeleteTpl(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("tpl").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
