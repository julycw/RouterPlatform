package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type ResourceType int

const (
	ResourceTypeOhter ResourceType = 1 + iota
	ResourceTypeText
	ResourceTypeMedia
	ResourceTypeImage
)

type Resource struct {
	Id       int64     `json:"id"`
	FileName string    `json:"file_name"`
	Alias    string    `json:"alias" form:"alias"`
	Path     string    `json:"path"`
	UserId   int64     `json:"uid"`
	Type     int       `json:"type" form:"type"`
	Md5      string    `json:"md5"`
	Size     int       `json:"size"`
	CreateOn time.Time `json:"create_on"`
	ModifyOn time.Time `json:"modify_on"`

	DisplayTag string `orm:"-" json:"-"`
}

func ResourceTypeName(in int) string {
	switch in {
	case int(ResourceTypeImage):
		return "图片"
	case int(ResourceTypeText):
		return "文本"
	case int(ResourceTypeMedia):
		return "媒体"
	case int(ResourceTypeOhter):
		return "其他"
	}
	return "未知"
}

func AddResource(obj Resource) (int64, error) {
	obj.CreateOn = time.Now()
	obj.ModifyOn = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return -1, err
	}
	return id, nil
}

func UpdateResource(id int64, update *Resource) (*Resource, error) {
	if obj, err := GetResource(id); err == nil {
		if update.Alias != "" {
			obj.Alias = update.Alias
		}
		if update.FileName != "" {
			obj.FileName = update.FileName
		}
		if update.Path != "" {
			obj.Path = update.Path
		}
		if update.UserId != 0 {
			obj.UserId = update.UserId
		}
		if update.Type != 0 {
			obj.Type = update.Type
		}
		if update.Md5 != "" {
			obj.Md5 = update.Md5
		}
		if update.Size != 0 {
			obj.Size = update.Size
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

func GetResource(id int64) (*Resource, error) {
	o := GetOrm()
	resource := new(Resource)
	if err := o.QueryTable("resource").Filter("Id", id).RelatedSel().One(resource); err != nil {
		return nil, err
	}
	return resource, nil
}

func GetAllResources(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Resource, int64, error) {
	o := GetOrm()
	var resources *[]Resource = new([]Resource)
	total, err := o.QueryTable("resource").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("resource").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(resources)
	if err != nil {
		return nil, 0, err
	}
	return resources, total, nil
}

func DeleteResource(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("resource").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
