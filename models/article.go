package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type ArticleVisible int

const (
	Visible ArticleVisible = 1 + iota
	Hidden
)

type Article struct {
	Id            int64     `json:"id"`
	Title         string    `json:"title"`
	FaceImagePath string    `json:"image"`
	UserId        int64     `json:"uid"`
	WebId         int64     `json:"wid"`
	TplId         int64     `json:"tid"`
	Order         int       `json:"order"`
	Description   string    `json:"desc"`
	CreateOn      time.Time `json:"create_on"`
	ModifyOn      time.Time `json:"modify_on"`
	Visible       int       `json:"visible"`
	Click         int       `json:"click"`

	TplName    string `json:"-" orm:"-"`
	VisibleStr string `json:"-" orm:"-"`
}

func ClickArticle(id int64) {
	GetOrm().Raw("UPDATE article SET click = click+1 WHERE id = ?", id).Exec()
}

func AddArticle(obj Article) (int64, error) {
	obj.CreateOn = time.Now()
	obj.ModifyOn = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return -1, err
	}
	return id, nil
}

func UpdateArticle(id int64, update *Article) (*Article, error) {
	if obj, err := GetArticle(id); err == nil {
		if update.Title != "" {
			obj.Title = update.Title
		}
		// if update.FaceImagePath != "" {
		obj.FaceImagePath = update.FaceImagePath
		// }
		if update.UserId != 0 {
			obj.UserId = update.UserId
		}
		if update.WebId != 0 {
			obj.WebId = update.WebId
		}
		if update.TplId != -1 {
			obj.TplId = update.TplId
		}
		if update.Order != 0 {
			obj.Order = update.Order
		}
		if update.Visible != 0 {
			obj.Visible = update.Visible
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
func GetArticle(id int64) (*Article, error) {
	o := GetOrm()
	article := new(Article)
	if err := o.QueryTable("article").Filter("Id", id).RelatedSel().One(article); err != nil {
		return nil, err
	}

	return article, nil
}

func GetAllArticles(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]Article, int64, error) {
	o := GetOrm()
	var articles *[]Article = new([]Article)
	total, err := o.QueryTable("article").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("article").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(articles)
	if err != nil {
		return nil, 0, err
	}
	return articles, total, nil
}

func DeleteArticle(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("article").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
