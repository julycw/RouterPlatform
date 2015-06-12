<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>{{.web.Title}}</title>
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/docs.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    *{
      font-family: "微软雅黑";
    }
    .list-group-item.selected{
      background-color: rgb(155, 197, 244);
    }
    .head-section-title{
      text-align: center;
      font-size: 18px;
      margin-bottom:20px;
      color:cadetblue;
    }
    ul.navbar-nav li{
      border-top: 1px solid silver;
    }
    .feature_well{
      min-height:200px;
      padding-bottom:20px;
    }
    .feature_well:nth-child(even){
      background-color: #e5e9ec;
    }
    .feature_well:nth-child(odd){
      background-color: white;
    }
    .ul-contact-info li h4{
      font-family: cursive;
      color:rgb(168, 168, 168);
    }
    .ul-contact-info li p{
      font-size:15px;
    }
    </style>
  </head>
  <body>
    <header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
      <div class="container" data-spy="affix" data-offset-top="0" style="width:100%;background-color:white;box-shadow: silver 0px 2px 2px;">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse" style="background-color:white;">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="/i/{{.web.Alias}}" class="navbar-brand" style="color:darkslateblue;"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> {{.web.Title}}</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse">
          <ul class="nav navbar-nav">
            <li style="border-top:none;">
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-article">产品呈现</a>
            </li>
            <li>
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-new">最新活动</a>
            </li>
            <li>
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-company">公司简介</a>
            </li>
            <li>
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-contact">联系方式</a>
            </li>
            <li>
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-explain">免责申明</a>
            </li>
            <li>
              <a href=".bs-navbar-collapse" data-toggle="collapse" target="#section-together">广告合作</a>
            </li>
            <li>
              <a href="#shareModal" data-toggle="modal">分享给好友</a>
            </li>
            <li>
              <a href="#addFeedbackModal" data-toggle="modal">意见反馈</a>
            </li>
          </ul>
        </nav>
      </div>
    </header>
    <!-- 内容开始 -->
    {{.LayoutContent}}
    <!-- 内容结束 -->
    <div class="feature_well">
      <div class="container">
        <div class="row">
          <h2 class="head-section-title even" id="section-explain"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> 免责申明</h2>
          <div class="col-sm-12 col-xs-12">
            <div class="well">
              <ul style="padding-left:10px;">
                <li>耶利米路由广告平台(www.jeremiah.cn，以下简称“耶利米”)提醒您：在使用耶利米提供的任何服务前，请务必仔细阅读并透彻理解本免责声明，您可以选择不使用耶利米提供的服务，但如果您使用耶利米的任何服务，您的使用行为将被视为对本声明全部内容的完全认可。<br/><a id="btnShowExplain" href="javascript:showExplain();">显示全部 >> </a></li>
                <div id="explain-all" style="display:none;">
                  <li>您通过使用耶利米提供的服务而获得的任何由第三方制作或提供之内容(包括但不限于针对第三方内容所进行的任何点评留言)，慈溪耶利米智能科技有限公司（以下简称“慈溪耶利米”）对其合法性、准确性、真实性、适用性、安全性等概不负责，亦不承担任何法律责任。因使用或依赖第三方提供内容或服务所产生的损失或损害，耶利米也不负担任何责任。</li>
                  <li>您通过耶利米搜索服务获到的任何第三方制作或提供之内容(包括但不限于针对第三方内容所进行的任何点评留言)是根据您键入的关键字自动搜索获得并生成的，不代表耶利米赞成其内容或立场。</li>
                  <li>一切因使用耶利米(包括但不限于针对第三方内容所进行的任何点评留言)而可能导致之任何意外、疏忽、违约、名誉或商誉诽谤、版权、知识产权或其他任何权利侵犯及其所造成的任何损失(包括但不限于因任何方式的下载而感染电脑病毒)，慈溪耶利米对其概不负责，亦不承担任何法律责任。</li>
                  <li>耶利米尊重并保护所有耶利米用户的个人隐私权，您注册的用户名、电子邮件地址等个人资料，非经您亲自许可或根据相关法律、法规的强制性规定，耶利米不会主动泄露至第三方。耶利米提醒您：您在使用耶利米搜索服务时所输入的关键字将不被视为您的个人隐私资料。</li>
                  <li>任何单位或个人认为通过耶利米搜索到的第三方内容可能涉嫌侵犯其信息网络传播权，应及时向慈溪耶利米提出书面权利通知，并提供身份证明、权属证明及详细情况证明，慈溪耶利米在收到上述法律文件后，将依法尽快停止对相关内容的收录。</li>
                  <li>您应该对使用耶利米的结果自行承担风险。耶利米不做任何形式的保证：不保证耶利米提供的服务完全满足您的要求，不保证耶利米的服务不中断，不保证耶利米网的服务的安全性、正确性、及时性、合法性。因网络状况、通讯线路等任何原因而导致您不能正常使用耶利米，耶利米概不负责，亦不对其承担任何法律责任。</li>
                  <li>您通过耶利米搜索到的耶利米之合作单位所提供的任何内容(包括但不仅限于图示、数据、文字等)，由该合作单位对其合法性、准确性、真实性、适用性、安全性等负责，耶利米对其不承担任何法律责任。<br/><a id="btnHideExplain" href="javascript:hideExplain();"> << 收起 </a></li>
                </div>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="feature_well">
      <div class="container">
        <div class="row">
          <h2 class="head-section-title odd" id="section-together"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> 广告合作</h2>
          <div class="col-sm-12 col-xs-12" style="text-align:center;">
            <span style="text-align:center;font-family:cursive;">Tel: <a style="font-family:cursive;color:orange;font-size: 22px;" href="tel:18758327133">18758327133</a></span>
            <br/>
            <span style="text-align:center;">Email: <a href="mailto:july@16me.cn" style="font-family:cursive;color: blue;font-size: 22px;">july@16me.cn</a></span>
            <br/>
            <span>
              <img style="margin-top:25px;width:100%;display:block;" src="/static/img/logo.png"/>
            </span>
          </div>
        </div>
      </div>
    </div>

    <div style="min-height:450px;background:-webkit-gradient(linear, left top, left bottom, from(#fff), to(#000));">
    </div>
    <div class="feature_well">
      <div id="footer" style="display: block;background-color:black;">
        <div class="container">
          <div class="row" style="color:gray;">
            <div class="col-sm-4 col-sm-offset-0 col-xs-6 col-1">
              <h4 style="color:white;">联系方式</h4>
              <a href="mailto:july@16me.cn">july@16me.cn</a><br>(0574) 66666666
            </div>
            <div class="col-sm-4 col-sm-offset-0 col-xs-5 col-xs-offset-1 col-2">
              <h4 style="color:white;">地址</h4>
              <span>宁波某地</span>
            </div>
            <div class="col-sm-4 col-xs-12 col-3">
              <h4 style="color:white;">相关</h4>
              <span>慈溪市耶利米智能科技有限公司</span><br/>
              <span><i id="copyrightsign">©</i> All Rights Reseverd</span><br/>
              <span>浙ICP备1500142</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 各种modal框 -->
      <!-- 添加反馈 -->
      <div class="modal fade" id="addFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="addFeedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="addFeedbackModalLabel">意见反馈</h4>
            </div>
            <div class="modal-body">
              <form>
                <div class="form-group">
                  <label for="add-feedback-input-content">建议内容</label>
                  <textarea class="form-control" id="add-feedback-input-content"></textarea>
                </div>
                <div class="form-group">
                  <label for="add-feedback-input-content">怎么联系您？</label>
                  <input type="text" class="form-control" id="add-feedback-input-contact" placeholder="比如您的QQ/Email/手机号等"></input>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" onclick="addFeedback();" class="btn btn-primary">保存</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="shareModalLabel">分享给朋友们</h4>
            </div>
            <div class="modal-body">
              <div class="bshare-custom icon-medium-plus"><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/button.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><a class="bshareDiv" onclick="javascript:return false;"></a><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
          </div>
        </div>
      </div>
      <!-- 添加反馈结束 -->

    <!-- 各种modal框结束 -->
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="/static/js/docs.min.js"></script>
    <script src="/static/js/router.js"></script>
    <script>
    $(function(){
      $("ul.nav.navbar-nav li a").on("click",function(){
        var $this = $(this);
        if($this.attr("target") != undefined){
          $('html,body').animate({scrollTop: $($this.attr("target"))[0].offsetTop-60}, 500);
        }
      });

      Hiwifi.init();
      Hiwifi.hide();
      setTimeout(function(){
        Hiwifi.show();
      },5000);
    });
    function addFeedback(){
      var content = $("#add-feedback-input-content").val();
      var contact = $("#add-feedback-input-contact").val();
      var feedback_to = {{.web.UserId}};
      $.ajax({
        type: 'POST',
        url: "/manage/feedback",
        data: JSON.stringify({
          "contact":contact,
          "content":content,
          "to":feedback_to
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            alert("收到~");
            $('#addFeedbackModal').modal('hide');
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function showExplain(){
      $("#btnShowExplain").hide();
      $("#btnHideExplain").show();
      $("#explain-all").slideDown();
      $('html,body').animate({scrollTop: $("#section-explain")[0].offsetTop-60}, 500);
    }

    function hideExplain(){
      $("#btnShowExplain").show();
      $("#btnHideExplain").hide();
      $("#explain-all").slideUp();
      $('html,body').animate({scrollTop: $("#section-explain")[0].offsetTop-60}, 500);
    }

    </script>
  </body>
</html>