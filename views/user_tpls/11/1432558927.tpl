<!DOCTYPE html>
<head lang="zh-CN">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公安执法影像管理系统</title>
<script language="JavaScript" src="/static/js/function.js"></script>
<script type="text/javascript" src="/static/js/poplay.js"></script>
<script type="text/javascript" src="/static/js/jquery-1.8.3.min.js"></script>



<style type="text/css">
img{border:none}
html{height:100%;}
body{margin:0px;padding:0px;overflow:hidden;padding-top:58px;padding-bottom:32px; ; color:#616161; font-size:12px;}
div{margin:0px;padding:0px;}
#header{color:white;position:absolute;top:0px;left:0px;height:58px;width:100%; background:url(/static/images/ui_03.jpg) repeat-x;}
#content{width:100%;height:100%;overflow:auto;}
#footer{color:white;width:100%;height:32px;position:absolute;bottom:0px;left:0px; background:url(/static/images/ui_09.jpg) repeat-x;}
.jg{width:2px; height:41px; float:right; background:url(/static/images/ui_12.jpg) no-repeat;}
.mainline{width:370px; height:41px; float:left; font-size:12px;  line-height:40px; font-weight:bold; overflow:hidden;}
.leftHov{
	color:#FFF;font-size:12px; 
	text-decoration:none;  
	text-align:center;
width:208px; height:38px;
line-height:38px;

	}
a.leftHov{
	color:#FFF;font-size:12px; 
	text-decoration:none;  
	text-align:center; 
width:208px; height:38px;

	}
a.leftHov:hover{width:208px; height:38px;color:#24426c;font-size:12px; text-decoration:none; text-align:center;}

.upDiv1{
	width:122px; height:40px; color:#FFF; text-align:center; line-height:40px; text-decoration:none;

	}
a.upDiv1{
	width:122px; height:40px;  color:#FFF;line-height:40px; text-align:center;text-decoration:none;

	}
a.upDiv1:hover{width:122px; height:40px;  color:#FFF;line-height:40px; text-align:center;text-decoration:none;}

.upDiv2{
	 color:#FFF; text-align:center; text-decoration:none; overflow:hidden; height:34px; line-height:35px;

	}
a.upDiv2{
	  color:#FFF; text-align:center;text-decoration:none;overflow:hidden;height:34px; line-height:35px;

	}
a.upDiv2:hover{  color:#FFF; text-align:center;text-decoration:none;overflow:hidden;height:34px; line-height:35px;}


#upDiv{width:122px; height:41px; float:left; background:url(/static/images/ui_068.jpg) no-repeat; text-align:center; font-size:12px; line-height:40px; }
a.szDiv{width:122px; height:41px; float:left; background:url(/static/images/ui_15.jpg) no-repeat ; color:#666;text-decoration:none; font-size:12px; text-align:center; line-height:39px;}
a.szDiv:hover{background:url(/static/images/ui_15.jpg)  no-repeat; background-position: 0 -41px; color:#FFF; text-decoration:none;font-size:12px;text-align:center; line-height:39px;}
a.l1{width:208px; height:38px; float:left; background:url(/static/images/ui_442.jpg) no-repeat;}
a.l1:hover{background:url(images/ui_442.jpg)  no-repeat; background-position: 0 -38px;}
a.l2{width:208px; height:38px; float:left; background:url(/static/images/tj.jpg) no-repeat;}
a.l2:hover{background:url(images/tj.jpg)  no-repeat; background-position: 0 -38px;}
a.l3{width:208px; height:38px; float:left; background:url(/static/images/BM.jpg) no-repeat;}
a.l3:hover{background:url(images/BM.jpg)  no-repeat; background-position: 0 -38px;}
a.l4{width:208px; height:38px; float:left; background:url(/static/images/glbm.jpg) no-repeat;}
a.l4:hover{background:url(images/glbm.jpg)  no-repeat; background-position: 0 -38px;}
a.l5{width:208px; height:38px; float:left; background:url(/static/images/tjry.jpg) no-repeat;}
a.l5:hover{background:url(images/tjry.jpg)  no-repeat; background-position: 0 -38px;}
a.l6{width:208px; height:38px; float:left; background:url(/static/images/glry.jpg) no-repeat;}
a.l6:hover{background:url(images/glry.jpg)  no-repeat; background-position: 0 -38px;}
a.l7{width:208px; height:38px; float:left; background:url(/static/images/tjal.jpg) no-repeat;}
a.l7:hover{background:url(images/tjal.jpg)  no-repeat; background-position: 0 -38px;}
a.l8{width:208px; height:38px; float:left; background:url(/static/images/glaj.jpg) no-repeat;}
a.l8:hover{background:url(images/glaj.jpg)  no-repeat; background-position: 0 -38px;}
input.ser{
	background:url(/static/images/ui_18.jpg) no-repeat;
	border:0px;
	width:228px;
	height:25px;
	vertical-align: top;
	padding-left:20px;
	line-height:22px;
	}
:focus { outline:0 }
.sec_menu  { overflow:hidden; }
.menu_title  { }
.menu_title span  { position:relative; top:0px; left:8px; color:#000000; font-weight:bold; }
.menu_title2  { }
.menu_title2 span  { position:relative; top:0px; left:8px; color:#999999; font-weight:bold; }

.menu_title{
  cursor: pointer;
}
.exitcss{color:#FFF; font-size:12px; }
a.exitcss{color:#FFF; font-size:12px; text-decoration:none;}
a.exitcss:hover{color:#404a54; font-size:12px;}
</style>
<script type="text/javascript">
var path='${pageContext.request.contextPath}';
function showmenu_item(sid) {
	var whichEl = eval("menu_item" + sid);
	var menuTitle = eval("menuTitle" + sid);
	if (whichEl.style.display == "none"){
		eval("menu_item" + sid + ".style.display=\"\";");
		if (sid != 0 & sid < 1000) {
			menuTitle.background="/static/images/title_bg_hide.gif";
		}
	}
}


</script>

<script type="text/javascript">
function myFunction(sid)
{
  var target = "#menu_item"+sid;
  $(target).toggle()
}

function iframeheight(){
  var frame = $("#myframe");

}
</script>
</head>

<body>
<div id="header"><a href="/login"><div style="float:left;cursor:pointer; background:url(/static/images/ui_01.jpg) no-repeat; width:342px; height:58px; margin:0px auto 0px 0px;"></div></a><div style="float:right; background:url(/static/images/ui_0413.jpg) no-repeat; width:182px; height:58px;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center">&nbsp;</td>
    </tr>
    <tr>
      <td height="30" align="center"><a href="/logout?action=logout" class="exitcss" ><img src="/static/images/uex_06.jpg" >&nbsp;退出系统</a></td>
    </tr>
    <tr>
      <td align="center"><strong></strong></td>
    </tr>
  </table></div></div>
<div id="content">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
 
  <tr>
    <td valign="top" width="208" style="background:url(/static/images/l.jpg) repeat-x #c3cad4;">
    <table width="208" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/static/images/ui_05.jpg" width="208" height="41"></td>
  </tr>
</table>
{{if .menu_zjrl}}
    <table cellpadding="0" cellspacing="0" width="208">
<tr>
  <td height="40" class="menu_title" id="menuTitle12" onClick="myFunction(12)" style="cursor:hand;"><div style="height:40px; width:208px; text-align:center; font-size:12px; color:#FFF; line-height:38px; background:url(/static/images/ui_20.jpg) no-repeat;"><b></b>证据录入</div></td>
</tr>
<tr>
<td  id='menu_item12'><div class="sec_menu" style="width:208px;">

<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr >
  <td height="38" align="center" valign="middle" style="background:url(/static/images/zj.gif) no-repeat; background-position: 45px 10px; "  ><a href="/evidence/upload" target="main"  class="leftHov"> 刑侦证据录入</a></td>
</tr>
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">

<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>
</table>
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr >
  <td height="38" align="center" valign="middle" style="background:url(/static/images/zj.gif) no-repeat; background-position: 45px 10px; "  ><a href="/static/download.html" target="main"  class="leftHov">下载程序</a></td>
</tr>
</table>

</td>
</tr>
</table>
{{else}}
{{end}}
{{if .menu_zjgl}}
    <table cellpadding="0" cellspacing="0" width="208">
<tr>
  <td height="40" class="menu_title" id="menuTitle9"  onClick="myFunction(9)" style="cursor:hand;"><div style="height:40px; width:208px; text-align:center; font-size:12px; color:#FFF; line-height:38px; background:url(/static/images/ui_20.jpg) no-repeat;"><b>证据影像管理</b></div></td>
</tr>
<tr>
<td  id='menu_item9'>
{{if .menu_yxcx}}
  <div class="sec_menu" style="width:208px;">
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr >
  <td height="38" align="center" valign="middle" style="background:url(/static/images/c.gif) no-repeat; background-position: 45px 10px; "  ><a href="/evidence/list" target="main"  class="leftHov">影像查询管理</a></td>
</tr>
</table>

<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>
  <div class="sec_menu" style="width:208px;">
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr >
  <td height="38" align="center" valign="middle" style="background:url(/static/images/c.gif) no-repeat; background-position: 45px 10px; "><a href="ftp://10.119.61.1:21/{{.usernum}}" target="main"  class="leftHov">我的文件夹</a></td>
</tr>
</table>
</div>
{{else}}
{{end}}

</div>
{{if .menu_zfbb}}

<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>
<table cellpadding="0" cellspacing="0" align="center" width="208">
<tr>
<td height="38" align="center"  style="background:url(/static/images/zj.gif) no-repeat; background-position: 45px 9px; "><a href="/evidence/report" target="main" class="leftHov">证据报表</a></td>
</tr>
</table>
{{else}}
{{end}}
</td>
</tr>
</table>
{{else}}
{{end}}
{{if .menu_jcgl}}     
<table cellpadding="0" cellspacing="0" width="208">
<tr>
<td height="25" class="menu_title"  id="menuTitle11"  onClick="myFunction(11)" style="cursor:hand;"><div style="height:40px; width:208px; text-align:center; font-size:12px; color:#FFF; line-height:38px; background:url(/static/images/ui_20.jpg) no-repeat;"><b>基础数据管理</b></div></td>
</tr>
<tr>
<td id='menu_item11'>
{{if .menu_dwda}}

<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="38" align="center" style="background:url(/static/images/c4.gif) no-repeat; background-position: 45px 10px; "><a href="/basicdata/unit"  target="main" class="leftHov">管理单位档案</a></td>
</tr>
</table>
{{else}}
{{end}}
{{if .menu_ryda}}
<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="38" align="center" style="background:url(/static/images/c6.gif) no-repeat; background-position: 45px 10px; "><a href="/basicdata/user"  target="main" class="leftHov">管理人员档案</a></td>
</tr>
</table>
{{else}}
{{end}}

{{if .menu_ajlb}}
<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>

<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="38" align="center" style="background:url(/static/images/c8.gif) no-repeat; background-position: 45px 10px; "><a href="/basicdata/evidencetype"  target="main" class="leftHov"> 管理案件类别</a></td>
</tr>
</table>

<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">

<div style="width:208px; height:2px; background:url(/static/images/ui_38.jpg) repeat-x ; overflow:hidden;"></div>
</table>

{{else}}
{{end}}


</td>
</tr>
</table> 
{{else}}
{{end}}

{{if .xtsz}}
<table cellpadding="0" cellspacing="0" width="208">
<tr>
<td height="25" class="menu_title"  onClick="myFunction(13)"  id="menuTitle13"  style="cursor:hand;"><div style="height:40px; width:208px; text-align:center; font-size:12px; color:#FFF; line-height:38px; background:url(/static/images/ui_20.jpg) no-repeat;"><b>系统设置</b></div></td>
</tr>
  <tr>
  <td id='menu_item13'>
  {{if .jsqx}}

  <table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" style="background:url(/static/images/sz.gif) no-repeat; background-position: 45px 10px; "><a href="/systemset/quanxianlist"  target="main" class="leftHov"> 角色权限管理</a></td>
  </tr>
  </table>
  {{else}}
  {{end}}

  {{if .czrz}}
  <table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" style="background:url(/static/images/sz.gif) no-repeat; background-position: 45px 10px; "><a href="/systemset/sysloglist"  target="main" class="leftHov">操作日志管理</a></td>
  </tr>
  </table>
  {{else}}
  {{end}}
<table width="208"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
  <td height="38" align="center" style="background:url(/static/images/sz.gif) no-repeat; background-position: 45px 10px; "><a href="/systemset/updatepwd"  target="main" class="leftHov"> 用户密码修改</a></td>
</tr>
</table>
</td>
</tr>
</table> 
{{else}}
{{end}}
<td valign="top">
  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="375" height="41" align="center" style="background:url(/static/images/ui_10.jpg) repeat-x;"><div class="mainline">欢迎用户{{.username}} 所在单位：{{.userunit}}</div><div class="jg"></div></td>
        
       
        <td style="background:url(/static/images/ui_10.jpg) repeat-x;">&nbsp;</td>
        
      </tr>
      <tr>
        <td colspan="6" style="height:500px;"><iframe id="myframe" name="main" src="/evidence/list" height="100%" width="100% " frameborder="0" onload="iframeheight();"></iframe></td>
      </tr>
    </table></td>
  </tr>
</table>

</div>
<div id="footer"><div style="width:208px; height:32px; float:left;"><img src="/static/images/ui_07.jpg" width="208" height="32" /></div></div>


</body>
</html>