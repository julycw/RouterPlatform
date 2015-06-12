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
    ul.navbar-nav li{
      border-top: 1px solid silver;
    }
    </style>
  </head>
  <body>
    <header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
      <div class="container" data-spy="affix" data-offset-top="0" style="width:100%;background-color:rgba(255, 255, 255,0.9);box-shadow: silver 0px 2px 2px;">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <button id="btn-back" class="navbar-toggle collapsed" style="float:left;margin:5px 0px 0px 15px;" type="button">
            <span class="sr-only">返回</span>
            <span class="glyphicon glyphicon-menu-left" style="font-size:18px;"></span>
          </button>
          <h2 class="title" style="height:18px;line-height: 18px;font-size: 18px;text-align: center;margin-top:15px;">{{.article.Title}}</h2>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse">
          <ul class="nav navbar-nav">
            <li>
              <a href="/i/{{.web.Alias}}#section-article">产品呈现</a>
            </li>
            <li>
              <a href="/i/{{.web.Alias}}#section-new">最新活动</a>
            </li>
            <li>
              <a href="/i/{{.web.Alias}}#section-company">公司简介</a>
            </li>
            <li>
              <a href="/i/{{.web.Alias}}#section-contact">联系方式</a>
            </li>
            <li>
              <a href="/i/{{.web.Alias}}#section-explain">免责申明</a>
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
    <div class="container">
      <div class="row" style="padding:10px;background-color:#e5e9ec;background:-webkit-gradient(linear, left top, left bottom, from(#C2E5FF), to(#e5e9ec));color:gray;box-shadow: 0px 3px 10px gray;margin-bottom:7px;">
        <div class="col-sm-12 col-xs-12">
          <span class="glyphicon glyphicon-time" aria-hidden="true" style="color:orange;"></span> {{dateformat .article.ModifyOn "2006-01-02 15:04:05"}} 发布更新
        </div>
        <div class="col-sm-12 col-xs-12">
          <span class="glyphicon glyphicon-eye-open" aria-hidden="true" style="color:orange;"></span> {{.article.Click}}人浏览
        </div>
      </div>

      <!-- 内容开始 -->
      {{.LayoutContent}}
      <!-- 内容结束 -->
      
      <div class="row" style="height:60px;background-color:#e5e9ec;color:gray;box-shadow: 0px -3px 10px gray;">
      </div>

      <div class="row" style="min-height:450px;background:-webkit-gradient(linear, left top, left bottom, from(#e5e9ec), to(#000));">
      </div>

      <div class="row" style="background-color:black;">
        <!-- <footer style="text-align:center;padding-top:25px;">
          <span>慈溪市耶利米智能科技有限公司</span><br/>
          <span><i id="copyrightsign">©</i> All Rights Reseverd</span><br/>
          <span>浙ICP备1500142</span>
        </footer> -->
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
        <!-- 添加反馈结束 -->

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
      <!-- 各种modal框结束 -->
    </div>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="/static/js/docs.min.js"></script>
    <script>

    $(function(){
      $("ul.nav.navbar-nav li a").on("click",function(){
        var $this = $(this);
        if($this.attr("target") != undefined){
          $('html,body').animate({scrollTop: $($this.attr("target"))[0].offsetTop-60}, 500);
        }
      });

      $("#btn-back").on("click",function(){
        window.location.href= "/i/{{.web.Alias}}#section-article";
      });
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
    </script>
  </body>
</html>