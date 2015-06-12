package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type LogCategory int

const (
	LogInfo LogCategory = 1 + iota
	LogDebug
	LogError
)

type Log struct {
	Id       int64     `json:"id"`
	UserId   int64     `json:"uid"`
	Content  string    `json:"content"`
	Category int       `json:"category"`
	Time     time.Time `json:"time"`
}

func GetLog(id int64) (*Log, error) {
	o := GetOrm()
	log := new(Log)
	if err := o.QueryTable("log").Filter("Id", id).RelatedSel().One(log); err != nil {
		return nil, err
	}

	return log, nil
}

func GetAllLogs(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Log, int64, error) {
	o := GetOrm()
	var logs *[]Log = new([]Log)
	total, err := o.QueryTable("log").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("log").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(logs)
	if err != nil {
		return nil, 0, err
	}
	return logs, total, nil
}

func AddLog(obj Log) (int64, error) {
	obj.Time = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return 0, err
	}
	return id, nil
}
