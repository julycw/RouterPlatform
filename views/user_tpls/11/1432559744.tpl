<html>
<head>  
<script type="text/javascript">
    function login(){
      var userId=document.getElementById('username');
      var password=document.getElementById('password');
      var form=document.getElementById('form');
      if(userId.value==""){
        alert('用户名不能为空。');
        return;
      }
      if(password.value==""){
        alert('密码不能为空。');
        return;
      }
        
      form.target="";
      form.submit();
    }

    {{if .message}}
    alert({{.message}});
    {{end}}
    
    //window.open ("{{.base}}/static/tip2.html", "tip", "height=200,width=200");
</script>

<title></title>
</head>
 <body>
<style type="text/css">
html,body {
  font-family:"宋体", "新宋体", "微软雅黑";
  font-size: 12px;
  color: #414d56;
  margin:0px;
  width:100%;
  height:100%;
  line-height:20px;
  }
#login_page{
  width:100%;
  height:100%;
  background:#1f406a;
  margin:0px;
  text-align: center;
  }

input.dan{
  border:0px;
  vertical-align: top;
  margin-top:-3px;
  }
input.sub{
  border:0px;
  vertical-align: top;
  background:url(/static/images/login_24.jpg) no-repeat;
  }

:focus { outline:0 }
img {
  border:0px;
  }
a{
  
}
a:link {
  text-decoration:none;
  color: #42bae8;
}
a:visited {
  text-decoration:none;
  color:#42bae8;
}
a:hover {
  color:#34c7ff;
  text-decoration:underline;
}
a:active {
  text-decoration:none;
  color:#42bae8;
}
.titmore{
  font-weight:bold;
  color:#0ba9e5;
  }
  .shu{
    width:160px;
  }
</style>
<div id="login_page" >
<div style=" display: inline-block; width:960px;height:519px;margin:0px 0px 0px 20px; background: url(/static/images/login_05.jpg) no-repeat;  ">
  <div id="login">
    <form id="form" name="form" method="post" action="/login">
      <input type="hidden" name="action" value="login"></input>
      <table width="323" border="0" cellpadding="0" cellspacing="0" style=" margin:223px 0px 0px 397px;">
        <tr>
          <td width="120" align="right">用户名:</td>
          <td height="40" colspan="5"><label for="textfield"></label>
            <input class="shu" type="text" name="username" id="username" /></td>
        </tr>
        <tr>
          <td  width="120" align="right">密&nbsp;&nbsp;码:</td>
          <td height="40" colspan="5">
            <input class="shu" type="password" name="password" id="password" /></td>
        </tr>
        <tr>
          <td height="25" valign="middle">&nbsp;</td>
          
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td colspan="3">&nbsp;</td>
          <td width="5">&nbsp;</td>
          <td width="127" style="position:relative;left:-50px;"><a href="javascript:login()"><img src="/static/images/login_24.jpg" /></a></td>
        </tr>
      </table>
    </form>
  </div>
</div>
</div>
</body>
</html>
