<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>{{.Title}}</title>
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/docs.min.css" rel="stylesheet">
    <link href="static/css/site.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <div id="wrap">
      <!-- navigation -->
      <div id="topmostnav" class="navbar navbar-static-top public">
        <div class="container">
          <a href="/" title="Homepage">
            <div class="brand logo"><img src="/static/img/logo.png" alt="Logo" height="45" width="160"></div>
          </a>
          <ul class="nav">
            <li><a href="#" title="产品介绍">产品介绍</a></li>
          </ul>
          <div id="usernav" class="pull-right">
            <a id="btn-header-login" href="/auth/login" class="btn nav-button2" title="Login">登录</a>
          </div>
        </div>
      </div>
      <!-- end of navigation -->

      <!-- homepage -->
      <div id="homepage">
        <div class="wrapping-banner-home">
          <div class="container">
            <div class="row">
              <div class="span7">
                <div class="copy-block">
                  <h1>
                    <span class="eyebrow-header">让你的免费WIFI有所价值</span>
                    <br>
                    <span style="text-align:center;" class="header1">轻松获得广告位</span>
                    <br>
                  </h1>
                  <h2 class="subhead">balabala....</h2>
                </div>
              </div>
              <div class="span5">
                <div class="hub-overlay">
                  <h3>注册成为会员</h3>
                  <p>balabala....</p>
                  <form>
                    <div class="form-group">
                      <input class="form-control" id="id_username" maxlength="30" name="username" placeholder="用户名" type="text">
                      <p class="error-message">该项内容不正确</p>
                    </div>
                    <div class="form-group">
                      <input class="form-control" id="id_password" name="password" placeholder="密码" type="password">
                      <p class="error-message">该项内容不正确</p>
                    </div>
                    <div class="form-group">
                      <input class="form-control" id="id_verify" name="verify" placeholder="验证码" type="text">
                      <p class="error-message">该项内容不正确</p>
                    </div>
                    <a href="javascript:register();" class="btn signup-button btn-block" style="color:white;">免费注册</a>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- end of homepage -->
    </div>

    <div id="footer">
      footer
    </div>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>
    <script>
      $(function(){
      });
      function register(){
        var username = $("#id_username").val();
        var password = $("#id_password").val();
        var verify = $("#id_verify").val();
        $.post("/auth/register",{username:username,password:password,verify:verify},function(data){
          if(data.code === 0){
            window.location.href = "/manage"
          }else{
            alert(data.msg);
          }
        });
        return false;
      }
    </script>
  </body>
</html>