<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>{{.Title}}</title>
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/docs.min.css" rel="stylesheet">
    <link href="/static/css/site.css" rel="stylesheet">
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
          <div id="usernav" class="pull-right">
            <a id="btn-header-register" href="/" class="btn nav-button2" title="注册">注册</a>
          </div>
        </div>
      </div>
      <!-- end of navigation -->
 
      <!-- homepage -->
      <div id="homepage">
        <div class="wrapping-banner-home">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div class="hub-overlay" style="margin:80px auto;">
                  <h3>登录</h3>
                  <p>balabala....</p>
                  <form>
                    <div class="form-group">
                      <input class="form-control" id="id_username" maxlength="30" name="username" placeholder="用户名" type="text">
                    </div>
                    <div class="form-group">
                      <input class="form-control" id="id_password" name="password" placeholder="密码" type="password">
                    </div>
                    <div class="form-group">
                      <input class="form-control" id="id_verify" name="verify" placeholder="验证码" type="text">
                    </div>
                    <div class="form-group">
                      <a href="javascript:void(0);" onclick="changeVerifyImg();"><img id="verify_img" src="/auth/verify" style="background-color:white;"/></a>
                    </div>
                    <a href="javascript:login();" class="btn signup-button btn-block" style="color:white;">点击登录</a>
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
      function login(){
        var username = $("#id_username").val();
        var password = $("#id_password").val();
        var verify = $("#id_verify").val();
        $.post("/auth/login",{username:username,password:password,verify:verify},function(data){
          if(data.code === 0){
            window.location.href = "/manage"
          }else{
            alert(data.msg);
            changeVerifyImg();
          }
        });
      }

      function changeVerifyImg(){
        count++;
        $("#verify_img").attr("src","/auth/verify?r="+count);
      }
      var count = 0;
    </script>
  </body>
</html>