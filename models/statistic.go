package models

const (
	StatisticLineNum = 10
)

type Statistic struct {
	Id     int64  `json:"id"`
	Name   string `json:"name"`
	Count  int    `json:"count"`
	Random int    `json:"random"`
}

func (this *Statistic) Increase(name string) int {
	return 0
}

func (this *Statistic) GetCount(name string) int {
	return 0
}

func (this *Statistic) Initial(names ...string) {
	return
}
