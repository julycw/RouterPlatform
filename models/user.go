package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type User struct {
	Id          int64     `json:"id"`
	UserName    string    `json:"username"`
	Password    string    `json:"password"`
	Status      int       `json:"status"`
	CreateOn    time.Time `json:"create_on"`
	ModifyOn    time.Time `json:"modify_on"`
	LastLoginOn time.Time `json:"last_login_on"`

	UserProfile *UserProfile `json:"profile" orm:"rel(one)"`
}

type UserProfile struct {
	Id       int64     `json:"id"`
	RealName string    `json:"realname"`
	Phone    string    `json:"phone"`
	Email    string    `json:"email"`
	Address  string    `json:"address"`
	Gender   int       `json:"gender"`
	ModifyOn time.Time `json:"modify_on"`
}

type UserOption struct {
	Id              int64 `json:"id"`
	UserId          int64
	MaxRouterNum    int
	MaxWebNum       int
	MaxTplNum       int
	MaxResourceSize int
}

func AddUser(obj User) (int64, error) {
	var id int64
	var profileId int64
	var err error
	o := GetOrm()
	if err = o.Begin(); err == nil {
		obj.CreateOn = time.Now()
		obj.ModifyOn = time.Now()
		if obj.UserProfile == nil {
			obj.UserProfile = &UserProfile{
				ModifyOn: time.Now(),
			}
		} else {
			obj.UserProfile.ModifyOn = time.Now()
		}
		if profileId, err = o.Insert(obj.UserProfile); err == nil {
			obj.UserProfile.Id = profileId
			if id, err = o.Insert(&obj); err != nil {
				o.Rollback()
				return 0, err
			} else {
				if _, err = o.Insert(&UserOption{
					UserId:          id,
					MaxRouterNum:    OptionMaxRouterNum(),
					MaxWebNum:       OptionMaxWebNum(),
					MaxTplNum:       OptionMaxTplNum(),
					MaxResourceSize: OptionMaxResourceSize(),
				}); err != nil {
					o.Rollback()
					return 0, err
				}
			}
		} else {
			o.Rollback()
			return 0, err
		}

	} else {
		return 0, err
	}
	o.Commit()

	return id, nil
}

func GetUser(id int64) (*User, error) {
	o := GetOrm()
	user := new(User)
	if err := o.QueryTable("user").Filter("id", id).RelatedSel().One(user); err != nil {
		return nil, err
	}
	return user, nil
}

func GetUserProfile(id int64) (*UserProfile, error) {
	o := GetOrm()
	user := new(User)
	if err := o.QueryTable("user").Filter("id", id).One(user, "UserProfile"); err != nil {
		return nil, err
	}
	profile := new(UserProfile)
	if err := o.QueryTable("user_profile").Filter("id", user.UserProfile.Id).One(profile); err != nil {
		return nil, err
	}
	return profile, nil
}

func GetUserOption(id int64) (*UserOption, error) {
	o := GetOrm()
	option := new(UserOption)
	if err := o.QueryTable("user_option").Filter("user_id", id).One(option); err != nil {
		return nil, err
	}
	return option, nil
}

func GetAllUsers(cond *orm.Condition, pageIndex, pageSize int, order ...string) (*[]User, int64, error) {
	o := GetOrm()
	var users *[]User = new([]User)
	total, err := o.QueryTable("user").SetCond(cond).Count()
	if err != nil {
		return nil, 0, err
	}
	_, err = o.QueryTable("user").SetCond(cond).Limit(pageSize, (pageIndex-1)*pageSize).OrderBy(order...).All(users)
	if err != nil {
		return nil, 0, err
	}
	return users, total, nil
}

func UpdateUser(id int64, update *User) (*User, error) {
	if obj, err := GetUser(id); err == nil {
		if update.UserName != "" {
			obj.UserName = update.UserName
		}
		if update.Password != "" {
			obj.Password = update.Password
		}
		if update.UserProfile != nil && obj.UserProfile != nil {
			if profile, err := UpdateUserProfile(id, update.UserProfile); err == nil {
				obj.UserProfile = profile
			}
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

func UpdateUserProfile(id int64, update *UserProfile) (*UserProfile, error) {
	if obj, err := GetUserProfile(id); err == nil {
		if update.RealName != "" {
			obj.RealName = update.RealName
		}
		if update.Gender != 0 {
			obj.Gender = update.Gender
		}
		if update.Email != "" {
			obj.Email = update.Email
		}
		if update.Address != "" {
			obj.Address = update.Address
		}
		if update.Phone != "" {
			obj.Phone = update.Phone
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

func DeleteUser(id int64) error {
	o := GetOrm()
	_, err := o.QueryTable("user").Filter("Id", id).Delete()
	if err != nil {
		return err
	}
	return nil
}
