package models

import (
	"fmt"
	"github.com/astaxie/beego/orm"
	"github.com/julycw/RouterPlatform/tools"
	"strings"
	"time"
)

type Router struct {
	Id         int64     `json:"id"`
	Sn         string    `json:"sn"`
	Alias      string    `json:"alias"`
	MacAddress string    `json:"mac"`
	UserId     int64     `json:"uid"`
	WebId      int64     `json:"wid"`
	CreateOn   time.Time `json:"create_on"`
	ModifyOn   time.Time `json:"modify_on"`

	IfSelected string `json:"-" orm:"-"`
}

func AddRouter(router Router) (int64, error) {
	router.CreateOn = time.Now()
	router.ModifyOn = time.Now()
	o := GetOrm()
	if err := o.Begin(); err == nil {
		alias := fmt.Sprintf("%d%d", router.UserId, time.Now().Unix())
		web := Web{
			UserId:       router.UserId,
			Alias:        tools.MD5(alias)[:6],
			Title:        router.Alias,
			Address:      "",
			ContactName:  "",
			ContactPhone: "",
			Email:        "",
			Qq:           "",
			Description:  "",
			TplId:        0,
			Click:        0,
			CreateOn:     time.Now(),
			ModifyOn:     time.Now(),
		}
		if webId, err := o.Insert(&web); err == nil {
			router.WebId = webId
			router.MacAddress = strings.Replace(router.MacAddress, "-", "", -1)
			if routerId, err := o.Insert(&router); err == nil {
				if err := o.Commit(); err == nil {
					return routerId, nil
				} else {
					o.Rollback()
					return 0, err
				}
			} else {
				o.Rollback()
				return 0, err
			}
		} else {
			o.Rollback()
			return 0, err
		}
	} else {
		return 0, err
	}
}

func UpdateRouter(id int64, update *Router) (*Router, error) {
	if obj, err := GetRouter(id); err == nil {
		if update.Sn != "" {
			obj.Sn = update.Sn
		}
		if update.Alias != "" {
			obj.Alias = update.Alias
		}
		if update.MacAddress != "" {
			obj.MacAddress = strings.Replace(update.MacAddress, "-", "", -1)
		}
		if update.UserId != 0 {
			obj.UserId = update.UserId
		}
		if update.WebId != 0 {
			obj.WebId = update.WebId
		}
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

func GetRouter(id int64) (*Router, error) {
	o := GetOrm()
	router := new(Router)
	if err := o.QueryTable("router").Filter("Id", id).RelatedSel().One(router); err != nil {
		return nil, err
	}

	if len(router.MacAddress) == 16 {
		router.MacAddress = fmt.Sprintf("%s-%s-%s-%s-%s-%s-%s-%s", router.MacAddress[:2], router.MacAddress[2:4], router.MacAddress[4:6], router.MacAddress[6:8], router.MacAddress[8:10], router.MacAddress[10:12], router.MacAddress[12:14], router.MacAddress[14:16])
	}
	return router, nil
}

func GetAllRouters(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Router, int64, error) {
	o := GetOrm()
	var routers *[]Router = new([]Router)
	total, err := o.QueryTable("router").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("router").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(routers)
	if err != nil {
		return nil, 0, err
	}
	for i, v := range *routers {
		if len(v.MacAddress) == 16 {
			(*routers)[i].MacAddress = fmt.Sprintf("%s-%s-%s-%s-%s-%s-%s-%s", v.MacAddress[:2], v.MacAddress[2:4], v.MacAddress[4:6], v.MacAddress[6:8], v.MacAddress[8:10], v.MacAddress[10:12], v.MacAddress[12:14], v.MacAddress[14:16])
		}
	}
	return routers, total, nil
}

func DeleteRouter(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("router").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
