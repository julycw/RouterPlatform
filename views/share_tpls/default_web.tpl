<div class="feature_well">
  <div class="container">
    <div class="row">
      <h2 class="head-section-title even" id="section-article"><span class="glyphicon glyphicon-gift" aria-hidden="true"></span> 产品展示</h2>
    </div>
    <div class="row">
      {{range .articles}}
      <div class="col-sm-6 col-xs-6 col-md-3" style="margin-bottom:20px;">
        <a href="/i/article/{{.Id}}">
          <div class="article-item" style="border: 5px solid white;box-shadow: 2px 2px 5px silver;  background-color: white;">
            <div class="article-item-image">
                <img src="{{.FaceImagePath}}" class="img-responsive">
            </div>
            <div class="article-item-title" style="">
              <p style="color:white;line-height:30px;background-color:rgb(17, 184, 178);text-align: center;margin-bottom:0px;height:30px;">{{.Title}}</p>
            </div>
          </div>
        </a>
      </div>
      {{end}}
    </div>
  </div>
</div>


<div class="feature_well">
  <div class="container">
    <div class="row">
      <h2 class="head-section-title odd" id="section-new"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 最新活动</h2>
      <div class="col-sm-12 col-xs-12" style="text-align:center;">
        <p>暂时没有活动:(</p>
      </div>
    </div>
  </div>
</div>

<div class="feature_well">
  <div class="container">
    <div class="row">
      <h2 class="head-section-title odd" id="section-company"><span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span> 公司简介</h2>
      <div class="col-sm-12 col-xs-12">
        <div style="text-indent:2em;" class="well">
        {{if .web.Description}}
          {{.web.Description}}
        {{else}}
          <p>店家尚未填写公司简介内容？赶紧<a href="#addFeedbackModal" data-toggle="modal">通知一下</a>他吧！</p>
        {{end}}
        </div>
      </div>
    </div>
  </div>
</div>
<div class="feature_well">
  <div class="container">
    <div class="row">
      <h2 class="head-section-title even" id="section-contact"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> 联系方式</h2>
      <div class="col-sm-12 col-xs-12">
        <div>
          <ul class="ul-contact-info">
            {{if .web.ContactName}}
            <li>
              <h4>Name</h4>
              <p>{{.web.ContactName}}</p>
            </li>
            {{end}}
            {{if .web.ContactPhone}}
            <li>
              <h4>Phone</h4>
              <p>{{.web.ContactPhone}}</p>
            </li>
            {{end}}
            {{if .web.Email}}
            <li>
              <h4>Email</h4>
              <p>{{.web.Email}}</p>
            </li>
            {{end}}
            {{if .web.Qq}}
            <li>
              <h4>QQ</h4>
              <p>{{.web.Qq}}</p>
            </li>
            {{end}}
            {{if .web.Address}}
            <li>
              <h4>Address</h4>
              <p>{{.web.Address}}</p>
            </li>
            {{end}}
          </ul>
          {{if .lackOfContactInfo}}
          <p>店家的联系方式还不够丰富？赶紧<a href="#addFeedbackModal" data-toggle="modal">通知一下</a>他吧！</p>
          {{end}}
        </div>
      </div>
    </div>
  </div>
</div>