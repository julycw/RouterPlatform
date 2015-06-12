package models

import (
	"time"
)

type Feedback struct {
	Id         int64     `json:"id"`
	UserId     int64     `json:"uid"`
	Contact    string    `json:"contact"`
	Content    string    `json:"content"`
	FeedbackTo int64     `json:"to"`
	Flags      string    `json:"flags"`
	CreateOn   time.Time `json:"create_on"`
}

func AddFeedback(obj Feedback) (int64, error) {
	obj.CreateOn = time.Now()
	o := GetOrm()
	id, err := o.Insert(&obj)
	if err != nil {
		return -1, err
	}
	return id, nil
}
