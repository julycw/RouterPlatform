<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>站点管理</title>
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/docs.min.css" rel="stylesheet">
    <link href="/static/css/manage.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    {{if .PageMessage}}
    {{str2html .PageMessage}}
    {{end}}
    <header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
      <div class="container">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="/manage" class="navbar-brand">管理页面</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="selected">
              <a href="/manage/web">站点管理</a>
            </li>
            <li>
              <a href="/manage/tpl">模板管理</a>
            </li>
            <li>
              <a href="/manage/resource">资源管理</a>
            </li>
            <li>
              <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">修改密码</a>
            </li>
            <li>
              <a href="#" data-toggle="modal" data-target="#addFeedbackModal">意见反馈</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="/auth/logout">注销</a></li>
          </ul>
        </nav>
      </div>
    </header>
    <div class="container">
      <div class="row" style="margin:10px 0px;">
        <div class="col-md-12">
          <div class="btn-group" role="group" aria-label="...">
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addWebModal">新增</button>
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteWebModal">删除</button>
          </div>
          <span class="pull-right">当前共有{{.total}}个站点，最多允许5个</span>
        </div>
      </div>
      <div class="row" style="margin:10px 0px;">
        <div class="col-md-12">
          <table class="table table-striped table-condensed table-hover">
            <thead>
              <tr>
                <th>选择</th>
                <th>别名</th>
                <th>标题</th>
                <th>模板</th>
                <th>创建时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              {{range .webs}}
              <tr>
                <th><input type="checkbox" class="tpl-list-checkbox" itemid="{{.Id}}"></input></th>
                <td>{{.Alias}}</td>
                <td>{{.Title}}</td>
                <td>{{.TplName}}</td>
                <td>{{dateformat .CreateOn "2006-01-02 15:04:05"}}</td>
                <td>
                  <a href="/i/{{.Alias}}" target="_blank">预览</a>/
                  <a href="javascript:showUpdateWebModal({{.Id}});">修改</a>
                </td>
              </tr>
              {{end}}
            </tbody>
          </table>
        </div>
      </div>

      <!-- 各种modal框 -->
        <!-- 删除Web -->
        <div class="modal fade" id="deleteWebModal" tabindex="-1" role="dialog" aria-labelledby="deleteWebModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteWebModalLabel">删除站点</h4>
              </div>
              <div class="modal-body">
                确定删除选中的站点吗？
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="deleteWeb();" class="btn btn-danger">确定</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 删除Web结束 -->

        <!-- 添加Web -->
        <div class="modal fade" id="addWebModal" tabindex="-1" role="dialog" aria-labelledby="addWebModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="/manage/web" method="post">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="addWebModalLabel">添加站点</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                      <label for="add-web-input-alias">别名</label>
                      <input name="alias"  type="text" class="form-control" id="add-web-input-alias" placeholder="别名">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-tpl">套用模板</label>
                      <select id="add-web-input-tpl" name="tpl" class="form-control" value="{{.web.TplId}}">
                          <option value="0">默认</option>
                          {{range .webTpls}}
                            <option value="{{.Id}}" {{.IfSelected}}>{{.Name}}</option>
                          {{end}}
                        </select>
                    </div>

                    <div class="form-group">
                      <label for="add-web-input-title">页面标题</label>
                      <input name="title"  type="text" class="form-control" id="add-web-input-title" placeholder="标题">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-description">页面描述</label>
                      <textarea class="form-control" name="desc"  id="add-web-input-description" placeholder="描述"></textarea>
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-contact-name">联系人</label>
                      <input name="contact_name"  type="text" class="form-control" id="add-web-input-contact-name" placeholder="联系人">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-contact-phone">联系电话</label>
                      <input name="contact_phone"  type="text" class="form-control" id="add-web-input-contact-phone" placeholder="联系电话">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-address">地址</label>
                      <input name="address"  type="text" class="form-control" id="add-web-input-address" placeholder="地址">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-email">电子邮件</label>
                      <input name="email" type="email" class="form-control" id="add-web-input-email" placeholder="电子邮件">
                    </div>
                    
                    <div class="form-group">
                      <label for="add-web-input-qq">QQ</label>
                      <input name="qq" type="text" class="form-control" id="add-web-input-qq" placeholder="QQ">
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                  <input type="submit" class="btn btn-primary" value="保存"></input>
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- 添加Web结束 -->

        <!-- 修改Web -->
        <div class="modal fade" id="updateWebModal" tabindex="-1" role="dialog" aria-labelledby="updateWebModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="/manage/web" method="post">
                <input type="hidden" id="update-web-input-id">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="updateWebModalLabel">修改站点</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                      <label for="update-web-input-alias">别名</label>
                      <input name="alias"  type="text" class="form-control" id="update-web-input-alias" placeholder="别名">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-tpl">套用模板</label>
                      <select id="update-web-input-tpl" name="tpl" class="form-control" value="{{.web.TplId}}">
                          <option value="0">默认</option>
                          {{range .webTpls}}
                            <option value="{{.Id}}" {{.IfSelected}}>{{.Name}}</option>
                          {{end}}
                        </select>
                    </div>

                    <div class="form-group">
                      <label for="update-web-input-title">页面标题</label>
                      <input name="title"  type="text" class="form-control" id="update-web-input-title" placeholder="标题">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-description">页面描述</label>
                      <textarea class="form-control" name="desc"  id="update-web-input-desc" placeholder="描述"></textarea>
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-contact-name">联系人</label>
                      <input name="contact_name"  type="text" class="form-control" id="update-web-input-contact-name" placeholder="联系人">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-contact-phone">联系电话</label>
                      <input name="contact_phone"  type="text" class="form-control" id="update-web-input-contact-phone" placeholder="联系电话">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-address">地址</label>
                      <input name="address"  type="text" class="form-control" id="update-web-input-address" placeholder="地址">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-email">电子邮件</label>
                      <input name="email" type="email" class="form-control" id="update-web-input-email" placeholder="电子邮件">
                    </div>
                    
                    <div class="form-group">
                      <label for="update-web-input-qq">QQ</label>
                      <input name="qq" type="text" class="form-control" id="update-web-input-qq" placeholder="QQ">
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                  <a href="javascript:updateWeb();" class="btn btn-primary">保存</a>
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- 修改Web结束 -->

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
    function showUpdateWebModal(id){
      var $this = $(this);
      $.get("/web/"+id,function(data){
        if(data.code === 0){
          $("#update-web-input-id").val(data.data.id);
          $("#update-web-input-qq").val(data.data.qq);
          $("#update-web-input-email").val(data.data.email);
          $("#update-web-input-address").val(data.data.address);
          $("#update-web-input-desc").val(data.data.desc);
          $("#update-web-input-title").val(data.data.title);
          $("#update-web-input-alias").val(data.data.alias);
          $("#update-web-input-contact-name").val(data.data.contact_name);
          $("#update-web-input-contact-phone").val(data.data.contact_phone);
          $("#update-web-input-tpl").val(data.data.tid);
          $("#updateWebModal").modal("show");
        }else{
          alert(data.msg);
          $this.parent().parent().fadeOut(function(){
            $this.parent().parent().remove();
          });
        }
      });
    }

    function deleteWeb(){
      $(".tpl-list-checkbox:checked").each(function(){
        var $this = $(this);
        var id = $this.attr("itemid");
        $.ajax({
          type: 'DELETE',
          url: "/manage/web/"+id,
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
      $("#deleteWebModal").modal("hide");
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

    
    function updateWeb(){
      var id = $("#update-web-input-id").val();
      var qq = $("#update-web-input-qq").val();
      var email = $("#update-web-input-email").val();
      var address = $("#update-web-input-address").val();
      var desc = $("#update-web-input-desc").val();
      var title = $("#update-web-input-title").val();
      var alias = $("#update-web-input-alias").val();
      var contact_name = $("#update-web-input-contact-name").val();
      var contact_phone = $("#update-web-input-contact-phone").val();
      var tid = $("#update-web-input-tpl").val();
      $.ajax({
        type: 'PUT',
        url: "/manage/web/"+id,
        data:JSON.stringify({
          address:address,
          qq:qq,
          email:email,
          desc:desc,
          title:title,
          alias:alias,
          contact_name:contact_name,
          contact_phone:contact_phone,
          tid:parseInt(tid)
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            alert("修改成功");
            // $("#item-qq-"+id).val(qq);
            // $("#item-email-"+id).val(email);
            // $("#item-address-"+id).val(address);
            // $("#item-desc-"+id).val(desc);
            // $("#item-title-"+id).val(title);
            // $("#item-alias-"+id).val(alias);
            // $("#item-contact-name-"+id).val(contact_name);
            // $("#item-contact-phone-"+id).val(contact_phone);
            // $("#updateTplModal").modal("hide");
            window.location.href="/manage/web";
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