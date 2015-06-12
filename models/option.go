package models

import (
	"strconv"
)

type Option struct {
	Id    int64 `json:"id"`
	Name  string
	Value string
}

func OptionMaxRouterNum() int {
	value, _ := getOption("MaxRouterNum")
	v, _ := strconv.Atoi(value)
	return v
}

func OptionMaxWebNum() int {
	value, _ := getOption("MaxWebNum")
	v, _ := strconv.Atoi(value)
	return v
}

func OptionMaxTplNum() int {
	value, _ := getOption("MaxTplNum")
	v, _ := strconv.Atoi(value)
	return v
}

func OptionMaxResourceSize() int {
	value, _ := getOption("MaxResourceSize")
	v, _ := strconv.Atoi(value)
	return v
}

func SetOptionMaxRouterNum(value int) error {
	return setOption("MaxRouterNum", strconv.Itoa(value))
}

func SetOptionMaxWebNum(value int) error {
	return setOption("MaxWebNum", strconv.Itoa(value))
}

func SetOptionMaxTplNum(value int) error {
	return setOption("MaxTplNum", strconv.Itoa(value))
}

func SetOptionMaxResourceSize(value int) error {
	return setOption("MaxResourceSize", strconv.Itoa(value))
}

func getOption(name string) (string, error) {
	o := GetOrm()
	option := new(Option)
	if err := o.QueryTable("option").Filter("Name", name).One(option); err != nil {
		return "", err
	}
	return option.Value, nil
}

func setOption(name, value string) error {
	o := GetOrm()
	option := new(Option)
	if err := o.QueryTable("option").Filter("Name", name).One(option); err == nil {
		if option.Value == value {
			return nil
		} else {
			option.Value = value
			if _, err := o.Update(option); err == nil {
				return nil
			} else {
				return err
			}
		}
	} else {
		if _, err := o.Insert(&Option{
			Name:  name,
			Value: value,
		}); err == nil {
			return nil
		} else {
			return err
		}
	}
}
