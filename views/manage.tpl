<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>内容管理</title>
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/docs.min.css" rel="stylesheet">
    <link href="/static/css/manage.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
      <div class="container">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse" style="background-color: white;">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="/manage" class="navbar-brand" style="background-color:white;font-weight:bold;">管理页面</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse">
          <ul class="nav navbar-nav">
            <li>
              <a href="/manage/web">站点管理</a>
            </li>
            <li>
              <a href="/manage/tpl">模板管理</a>
            </li>
            <li>
              <a href="/manage/resource">资源管理</a>
            </li>
            <li>
              <a href="javascript:void(0);" data-toggle="modal" data-target="#modifyPasswordModal">修改密码</a>
            </li>
            <li>
              <a href="javascript:void(0);" data-toggle="modal" data-target="#addFeedbackModal">意见反馈</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="/auth/logout">注销</a></li>
          </ul>
        </nav>
      </div>
    </header>
    <div class="container">
      <!-- 内容开始 -->
      <div class="row">
        <!-- 路由器列表 -->
        <div class="col-md-2">
          <div data-spy="affix" data-offset-top="50" style="margin-top:10px;width:190px;top:10px;" class="hidden-print hidden-xs hidden-sm">
            <div class="list-group">
              <div id="router-list" style="margin-bottom:5px;">
                {{range .routers}}
                <a href="/manage/{{.Alias}}" class="list-group-item {{.IfSelected}}">
                  <h4 class="list-group-item-heading">{{.Alias}}</h4>
                  <p class="list-group-item-text">{{.Sn}}</p>
                  <p class="list-group-item-text" style="font-size:8px;font-style:italic;">{{.MacAddress}}</p>
                </a>
                {{end}}
              </div>
              <a href="javascript:void(0);" class="list-group-item" data-toggle="modal" data-target="#addRouterModal">
                <h4 class="list-group-item-heading">添加路由器</h4>
                <p class="list-group-item-text">点击添加</p>
              </a>
            </div>
          </div>
        </div>
        <!-- 路由器列表结束 -->

        <!-- 路由器页面设置 -->
        <div class="col-md-10">
          <div class="row">
            <div class="col-md-12">
              <div class="panel panel-default" style="margin:10px 10px 0px 10px;">
                <div class="panel-body">
                  {{if .web}}
                  <span style="margin-right:20px;">
                    当前路由器：{{.router.Alias}}  
                    <a href="javascript:void(0);" data-toggle="modal" data-target="#updateRouterModal">编辑</a> 
                  </span>
                  <span style="margin-right:20px;">
                    当前绑定站点：{{.web.Alias}}  
                    <a href="javascript:void(0);" data-toggle="modal" data-target="#changeRouterWebModal">更改</a> 
                  </span>
                  <span>
                    访问地址：<a href="/i/{{.web.Alias}}" target="_blank">查看</a>  
                  </span>
                  {{else}}
                  <span style="margin-right:20px;">
                    您还没有任何路由器, 马上<a href="javascript:void(0);" data-toggle="modal" data-target="#addRouterModal" style="font-weight:bold;">创建</a>一个吧！ 
                  </span>
                  {{end}}
                </div>
              </div>
            </div>
          </div>
          {{if .web}}
          <div class="row">
            <!-- 菜单列表 -->
            <div class="col-md-2">
              <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm">
                <ul class="nav bs-docs-sidenav">
                  <li>
                    <a href="#section1">站点内容设置</a>
                    <ul class="nav">
                      <li><a href="#section1-base-info">基础信息</a></li>
                      <li><a href="#section1-articles">产品列表</a></li>
                    </ul>
                  </li>
                  <li>
                    <a href="#section2">统计</a>
                    <ul class="nav">
                      <li><a href="#section2-base">一般统计</a></li>
                    </ul>
                  </li>
                <a class="back-to-top" href="#top">
                  返回顶部
                </a>
              </nav>
            </div>
            <div class="col-md-10">
              <div class="bs-docs-section">
                <h1 id="section1" class="page-header">站点内容设置<a class="anchorjs-link" href="#section1"><span class="anchorjs-icon"></span></a></h1>
                <!-- 基础信息 -->
                <h2 id="section1-base-info">基础信息<a class="anchorjs-link" href="#section1-base-info"><span class="anchorjs-icon"></span></a></h2>
                <form class="form-horizontal">
                  <div class="form-group">
                    <label for="update-web-input-tpl" class="col-sm-2 control-label">套用模板</label>
                    <div class="col-sm-10">
                      <select id="update-web-input-tpl" class="form-control" value="{{.web.TplId}}">
                        <option value="0">默认</option>
                        {{range .webTpls}}
                          <option value="{{.Id}}" {{.IfSelected}}>{{.Name}}</option>
                        {{end}}
                      </select>
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="update-web-input-title" class="col-sm-2 control-label">页面标题</label>
                    <div class="col-sm-10">
                      <input value="{{.web.Title}}" type="text" class="form-control" id="update-web-input-title" placeholder="标题">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-description" class="col-sm-2 control-label">页面描述</label>
                    <div class="col-sm-10">
                      <textarea class="form-control" id="update-web-input-description" placeholder="描述">{{.web.Description}}</textarea>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-contact-name" class="col-sm-2 control-label">联系人</label>
                    <div class="col-sm-10">
                      <input value="{{.web.ContactName}}" type="text" class="form-control" id="update-web-input-contact-name" placeholder="联系人">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-contact-phone" class="col-sm-2 control-label">联系电话</label>
                    <div class="col-sm-10">
                      <input value="{{.web.ContactPhone}}" type="text" class="form-control" id="update-web-input-contact-phone" placeholder="联系电话">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-address" class="col-sm-2 control-label">地址</label>
                    <div class="col-sm-10">
                      <input value="{{.web.Address}}" type="text" class="form-control" id="update-web-input-address" placeholder="地址">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-email" class="col-sm-2 control-label">电子邮件</label>
                    <div class="col-sm-10">
                      <input value="{{.web.Email}}" type="email" class="form-control" id="update-web-input-email" placeholder="电子邮件">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="update-web-input-qq" class="col-sm-2 control-label">QQ</label>
                    <div class="col-sm-10">
                      <input value="{{.web.Qq}}" type="text" class="form-control" id="update-web-input-qq" placeholder="QQ">
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <a href="javascript:void(0);" onclick="updateWeb();" id="btn-save-base-info" class="btn btn-default">保存</a>
                    </div>
                  </div>
                </form>
                <!-- 基础信息结束 -->

                <!-- 产品列表 -->
                <h2 id="section1-articles">产品列表<a class="anchorjs-link" href="#section1-articles"><span class="anchorjs-icon"></span></a></h2>
                <div class="btn-group" role="group" aria-label="...">
                  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addArticleModal">添加</button>
                  <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteArticleModal">删除</button>
                </div>
                <table class="table table-striped table-condensed table-hover">
                  <thead>
                    <tr>
                      <th></th>
                      <th>#</th>
                      <th>标题</th>
                      <th>描述</th>
                      <th>创建时间</th>
                      <th>是否显示</th>
                      <th>操作</th>
                    </tr>
                  </thead>
                  <tbody id="table-article-list">
                    {{if .articles}}
                      {{range .articles}}
                      <tr>
                        <td>
                          <input type="checkbox" class="article-list-checkbox" itemid="{{.Id}}"></input>
                        </td>
                        <td>{{.Order}}</td>
                        <td>{{.Title}}</td>
                        <td>{{.Description}}</td>
                        <td>{{dateformat .CreateOn "2006-01-02 15:04:05"}}</td>
                        <td>{{.VisibleStr}}</td>
                        <td><a href="/i/article/{{.Id}}" target="_blank">预览</a>/<a href="javascript:showUpdateArticleModal({{.Id}});">修改</a></td>
                      </tr>
                      {{end}}
                    {{else}}
                      <tr>
                        <td>
                          还没有任何产品，赶紧<a href="javascript:void(0);" data-toggle="modal" data-target="#addArticleModal">添加</a>一个吧！
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                    {{end}}
                  </tbody>
                </table>
                <!-- 产品列表结束 -->

              </div>
              <div class="bs-docs-section">
                <h1 id="section2" class="page-header">统计<a class="anchorjs-link" href="#section2"><span class="anchorjs-icon"></span></a></h1>
                <h2 id="section2-base">概况<a class="anchorjs-link" href="#section2-base"><span class="anchorjs-icon"></span></a></h2>
                <p>balabala</p>
              </div>
            </div>
          </div>
          {{end}}
        </div>
        <!-- 路由器页面设置结束 -->

      </div>
      <!-- 内容结束 -->

      <!-- 各种modal框 -->
        <!-- 添加路由器 -->
        <div class="modal fade" id="addRouterModal" tabindex="-1" role="dialog" aria-labelledby="addRouterModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addRouterModalLabel">添加路由器</h4>
              </div>
              <div class="modal-body">
                <form>
                  <div class="form-group">
                    <label for="add-router-input-alias">别名(*)</label>
                    <input type="text" class="form-control" id="add-router-input-alias" placeholder="别名, 例如: 一楼大厅">
                  </div>
                  <div class="form-group">
                    <label for="add-router-input-sn">序列号</label>
                    <input type="text" class="form-control" id="add-router-input-sn" placeholder="序列号">
                  </div>
                  <div class="form-group">
                    <label for="add-router-input-mac">路由器mac地址</label>
                    <input type="text" class="form-control" id="add-router-input-mac" placeholder="mac地址">
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="addRouter();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 添加路由器结束 -->

        <!-- 编辑路由器 -->
        <div class="modal fade" id="updateRouterModal" tabindex="-1" role="dialog" aria-labelledby="updateRouterModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateRouterModalLabel">编辑路由器信息</h4>
              </div>
              <div class="modal-body">
                <form>
                  <div class="form-group">
                    <label for="update-router-input-alias">别名(*)</label>
                    <input type="text" value="{{.router.Alias}}" class="form-control" id="update-router-input-alias" placeholder="名称">
                  </div>
                  <div class="form-group">
                    <label for="update-router-input-sn">序列号</label>
                    <input type="text" value="{{.router.Sn}}" class="form-control" id="update-router-input-sn" placeholder="序列号">
                  </div>
                  <div class="form-group">
                    <label for="update-router-input-mac">路由器mac地址</label>
                    <input type="text" value="{{.router.MacAddress}}" class="form-control" id="update-router-input-mac" placeholder="mac地址">
                  </div>
                  <div class="form-group">
                    <a href="javascript:void(0);" class="btn btn-danger" style="width:100%;display:block;" id="btn-delete-router">删除 - 不可恢复</a>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="updateRouter();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 编辑路由器结束 -->

        <!-- 删除Article -->
        <div class="modal fade" id="deleteArticleModal" tabindex="-1" role="dialog" aria-labelledby="deleteArticleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteArticleModalLabel">删除产品</h4>
              </div>
              <div class="modal-body">
                确定删除选中的产品吗？
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="deleteArticle();" class="btn btn-danger">确定</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 删除Article结束 -->

        <!-- 添加Article -->
        <div class="modal fade" id="addArticleModal" tabindex="-1" role="dialog" aria-labelledby="addArticleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addArticleModalLabel">添加产品</h4>
              </div>
              <div class="modal-body">
                <form>
                  <div class="form-group">
                    <label for="add-article-input-title">标题(*)</label>
                    <input type="text" class="form-control" id="add-article-input-title" placeholder="名称">
                  </div>
                  <div class="form-group">
                    <label for="add-article-input-image">缩略图地址</label>
                    <input type="text" class="form-control" id="add-article-input-image" placeholder="缩略图地址">
                  </div>
                  <div class="form-group">
                    <label for="add-article-input-tpl">套用模板</label>
                    <select id="add-article-input-tpl" class="form-control">
                        <option value="0">默认</option>
                        {{range .articleTpls}}
                          <option value="{{.Id}}">{{.Name}}</option>
                        {{end}}
                      </select>
                  </div>
                  <div class="form-group">
                    <label for="add-article-input-order">排序(数字越小越靠前，最小为1)</label>
                    <input type="text" class="form-control" id="add-article-input-order" placeholder="排序">
                  </div>
                  <div class="form-group">
                    <label for="add-article-input-description">内容描述</label>
                    <input type="text" class="form-control" id="add-article-input-description" placeholder="内容描述">
                  </div>
                  <div class="form-group">
                    <label for="add-article-input-visible">是否可见</label>
                    <div class="form-control">
                    是<input type="radio" value="1" name="add-article-input-visible" checked="checked">
                    否<input type="radio" value="2" name="add-article-input-visible">
                    </div>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="addArticle();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 添加Article结束 -->

        <!-- 修改Article -->
        <div class="modal fade" id="updateArticleModal" tabindex="-1" role="dialog" aria-labelledby="updateArticleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateArticleModalLabel">修改产品</h4>
              </div>
              <div class="modal-body">
                <form>
                  <input type="hidden" id="update-article-input-id">
                  <div class="form-group">
                    <label for="update-article-input-title">标题(*)</label>
                    <input type="text" class="form-control" id="update-article-input-title" placeholder="名称">
                  </div>
                  <div class="form-group">
                    <label for="update-article-input-image">缩略图地址</label>
                    <input type="text" class="form-control" id="update-article-input-image" placeholder="缩略图地址">
                  </div>
                  <div class="form-group">
                    <label for="update-article-input-tpl">套用模板</label>
                    <select id="update-article-input-tpl" class="form-control">
                        <option value="0">默认</option>
                        {{range .articleTpls}}
                          <option value="{{.Id}}">{{.Name}}</option>
                        {{end}}
                      </select>
                  </div>
                  <div class="form-group">
                    <label for="update-article-input-order">排序(数字越小越靠前，最小为1)</label>
                    <input type="text" class="form-control" id="update-article-input-order" placeholder="排序">
                  </div>
                  <div class="form-group">
                    <label for="update-article-input-desc">内容描述</label>
                    <input type="text" class="form-control" id="update-article-input-desc" placeholder="内容描述">
                  </div>
                  <div class="form-group">
                    <label>是否可见</label>
                    <div class="form-control">
                    <label for="update-article-input-visible-1">是</label>
                    <input id="update-article-input-visible-1" type="radio" value="1" name="update-article-input-visible">
                    <label for="update-article-input-visible-2">否</label>
                    <input id="update-article-input-visible-2" type="radio" value="2" name="update-article-input-visible">
                    </div>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="updateArticle();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 修改Article结束 -->

        <!-- 修改路由器站点 -->
        <div class="modal fade" id="changeRouterWebModal" tabindex="-1" role="dialog" aria-labelledby="changeRouterWebModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="changeRouterWebModalLabel">修改路由器站点</h4>
              </div>
              <div class="modal-body">
                <form>
                  <div class="form-group">
                    <label for="select-web-list">站点</label>
                    <select id="select-web-list" class="form-control">
                      {{range .webs}}
                        <option value="{{.Id}}" {{.IfSelected}}>{{.Alias}}</option>
                      {{end}}
                    </select>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="changeRouterWeb();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 修改路由器站点结束 -->

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

        <!-- 修改密码 -->
        <div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="modifyPasswordModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modifyPasswordModalLabel">修改密码</h4>
              </div>
              <div class="modal-body">
                <form>
                  <div class="form-group">
                    <label for="modify-password-input-password">原密码</label>
                    <input type="password" class="form-control" id="modify-password-input-password">
                  </div>
                  <div class="form-group">
                    <label for="modify-password-input-new-password">新密码</label>
                    <input type="password" class="form-control" id="modify-password-input-new-password">
                  </div>
                  <div class="form-group">
                    <label for="modify-password-input-new-password2">确认密码</label>
                    <input type="password" class="form-control" id="modify-password-input-new-password2">
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="modifyPassword();" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 修改密码结束 -->

      <!-- 各种modal框结束 -->
    </div>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="/static/js/docs.min.js"></script>
    <script>
    var routerDeleteConfirm = 2;
    var routerDeleteConfirmText = ["问你最后一遍，不后悔？","真的真的要删除吗？","真的要删除吗？"];
    var routerId = "{{.router.Id}}";
    var webId = "{{.web.Id}}";
    $(function(){
      $("#btn-delete-router").on("click",function(){
        if(routerDeleteConfirm <0){
          $.ajax({
            type: 'DELETE',
            url: "/manage/router/"+routerId,
            contentType: "application/json; charset=utf-8",
            success: function(data){
              if(data.code === 0){
                window.location.href="/manage/";
              }else{
                alert(data.msg);
              }
            },
            dataType: "json"
          });
        }else{
          $("#btn-delete-router").text(routerDeleteConfirmText[routerDeleteConfirm]);
          routerDeleteConfirm--;
        }
      });
    });

    function changeRouterWeb(){
      var webid = $("#select-web-list").val();
      $.ajax({
        type: 'PUT',
        url: "/manage/router/"+routerId,
        data: JSON.stringify({"wid":parseInt(webid)}),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            window.location.href="/manage/{{.router.Alias}}";
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function deleteArticle(){
      $(".article-list-checkbox:checked").each(function(){
        var $this = $(this);
        var id = $this.attr("itemid");
        $.ajax({
          type: 'DELETE',
          url: "/manage/article/"+id,
          contentType: "application/json; charset=utf-8",
          success: function(data){
            if(data.code === 0){
              $this.parent().parent().fadeOut(function(){
                $this.parent().parent().remove();
              });
            }else{
              alert(data.msg);
            }
          },
          dataType: "json"
        });
      });
      $('#deleteArticleModal').modal('hide');
    }

    function addFeedback(){
      var content = $("#add-feedback-input-content").val();
      $.ajax({
        type: 'POST',
        url: "/manage/feedback",
        data: JSON.stringify({
          "content":content,
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

    function modifyPassword(){
      var password = $("#modify-password-input-password").val();
      var new_password = $("#modify-password-input-new-password").val();
      var new_password2 = $("#modify-password-input-new-password2").val();

      if(new_password === ""){
        alert("密码不能为空");
        return;
      }
      if(new_password !== new_password2){
        alert("两次密码输入不一致");
        return;
      }
      $.post("/auth/changePassword",{
          "password":password,
          "new_password":new_password,
        },function(data){
          if(data.code === 0){
            alert("修改成功");
            $('#modifyPasswordModal').modal('hide');
          }else{
            alert(data.msg);
          }
        }
      );
    }

    function addArticle(){
      var title = $("#add-article-input-title").val();
      var image = $("#add-article-input-image").val();
      var tpl = $("#add-article-input-tpl").val();
      var order = $("#add-article-input-order").val();
      var description = $("#add-article-input-description").val();
      var visible = $("input[name='add-article-input-visible']:checked").val();
      $.ajax({
        type: 'POST',
        url: "/manage/article",
        data: JSON.stringify({
          "wid":parseInt(webId),
          "title":title,
          "image":image,
          "tpl":parseInt(tpl),
          "order":parseInt(order),
          "desc":description,
          "visible":parseInt(visible)
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            // $('#addArticleModal').modal('hide');
            // var html = "<tr><th><input type=\"checkbox\" class=\"article-list-checkbox\" itemid=\""+data.data+"\"></input></th><th>"+order+"</th><td>"+title+"</td><td>"+description+"</td><td>最近添加</td><td><a href=\"/i/article/"+data.data+"\" target=\"_blank\">预览</a>/<a href=\"javascript:void(0);\">修改</a></td></tr>";

            // $("#table-article-list").append(html);
            window.location.reload();
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function addRouter(){
      var alias = $("#add-router-input-alias").val();
      var sn = $("#add-router-input-sn").val();
      var mac = $("#add-router-input-mac").val();
      $.ajax({
        type: 'POST',
        url: "/manage/router",
        data: JSON.stringify({"alias":alias,"sn":sn,"mac":mac}),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            window.location.href="/manage/"+alias;
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function updateRouter(){
      var alias = $("#update-router-input-alias").val();
      var sn = $("#update-router-input-sn").val();
      var mac = $("#update-router-input-mac").val();
      $.ajax({
        type: 'PUT',
        url: "/manage/router/"+routerId,
        data: JSON.stringify({"alias":alias,"sn":sn,"mac":mac}),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            window.location.href="/manage/"+alias;
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function updateWeb(){
      var title = $("#update-web-input-title").val();
      var address = $("#update-web-input-address").val();
      var description = $("#update-web-input-description").val();
      var contactName = $("#update-web-input-contact-name").val();
      var contactPhone = $("#update-web-input-contact-phone").val();
      var email = $("#update-web-input-email").val();
      var qqNumber = $("#update-web-input-qq").val();
      var tpl = parseInt($("#update-web-input-tpl").val());
      $.ajax({
        type: 'PUT',
        url: "/manage/web/"+webId,
        data: JSON.stringify({
          "title":title,
          "address":address,
          "contact_name":contactName,
          "contact_phone":contactPhone,
          "qq":qqNumber,
          "email":email,
          "desc":description,
          "tid":tpl
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            $("#update-web-input-title").val(title);
            $("#update-web-input-description").val(description);
            $("#update-web-input-contact-name").val(contactName);
            $("#update-web-input-contact-phone").val(contactPhone);
            $("#update-web-input-email").val(email);
            $("#update-web-input-qq").val(qqNumber);
            $("#update-web-input-address").val(address);
            $("#update-web-input-tpl").val(tpl);
            alert("保存成功");
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function showUpdateArticleModal(id){
      var $this = $(this);
      $.get("/article/"+id,function(data){
        if(data.code === 0){
          $("#update-article-input-id").val(data.data.id);
          $("#update-article-input-title").val(data.data.title);
          $("#update-article-input-image").val(data.data.image);
          $("#update-article-input-tpl").val(data.data.tid);
          $("#update-article-input-order").val(data.data.order);
          $("#update-article-input-desc").val(data.data.desc);
          if(data.data.visible == 1){
            $("#update-article-input-visible-1").prop("checked",true);
            $("#update-article-input-visible-2").prop("checked",false);
          }else{
            $("#update-article-input-visible-1").prop("checked",false);
            $("#update-article-input-visible-2").prop("checked",true);
          }

          $("#updateArticleModal").modal("show");
        }else{
          alert(data.msg);
          $this.parent().parent().fadeOut(function(){
            $this.parent().parent().remove();
          });
        }
      });
    }

    function updateArticle(){
      var id = $("#update-article-input-id").val();
      var title = $("#update-article-input-title").val();
      var image = $("#update-article-input-image").val();
      var tid = $("#update-article-input-tpl").val();
      var order = $("#update-article-input-order").val();
      var desc = $("#update-article-input-desc").val();
      var visible = $("input[name='update-article-input-visible']:checked").val();
      $.ajax({
        type: 'PUT',
        url: "/manage/article/"+id,
        data: JSON.stringify({
          "title":title,
          "tid":parseInt(tid),
          "image":image,
          "order":parseInt(order),
          "desc":desc,
          "visible":parseInt(visible)
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            alert("保存成功");
            window.location.reload();
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