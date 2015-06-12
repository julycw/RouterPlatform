<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>模板管理</title>
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
            <li>
              <a href="/manage/web">站点管理</a>
            </li>
            <li class="selected">
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
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addTplModal">新增</button>
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteTplModal">删除</button>
          </div>
          <span class="pull-right">当前共有{{.total}}个模板文件，最多允许20个</span>
        </div>
      </div>
      <div class="row" style="margin:10px 0px;">
        <div class="col-md-12">
          <table class="table table-striped table-condensed table-hover">
            <thead>
              <tr>
                <th>选择</th>
                <th>名称</th>
                <th>类型</th>
                <th>创建时间</th>
                <th>备注</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              {{range .tpls}}
              <tr>
                <th><input type="checkbox" class="tpl-list-checkbox" itemid="{{.Id}}"></input></th>
                <td>{{.Name}}</td>
                <td>{{.Type | TplTypeName}}</td>
                <td>{{dateformat .CreateOn "2006-01-02 15:04:05"}}</td>
                <td>{{.Description}}</td>
                <td><a href="/i/tpl/{{.Id}}" target="_blank">预览</a>/<a href="javascript:showUpdateTplModal({{.Id}});">修改</a></td>
              </tr>
              {{end}}
            </tbody>
          </table>
        </div>
      </div>

      <!-- 各种modal框 -->
        <!-- 删除Tpl -->
        <div class="modal fade" id="deleteTplModal" tabindex="-1" role="dialog" aria-labelledby="deleteTplModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteTplModalLabel">删除模板</h4>
              </div>
              <div class="modal-body">
                确定删除选中的模板吗？
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" onclick="deleteTpl();" class="btn btn-danger">确定</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 删除Tpl结束 -->

        <!-- 添加Tpl -->
        <div class="modal fade" id="addTplModal" tabindex="-1" role="dialog" aria-labelledby="addTplModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="/manage/tpl" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="addTplModalLabel">添加模板</h4>
                </div>
                <div class="modal-body">
                  <div class="form-group">
                    <label for="add-tpl-input-name">名称(*)</label>
                    <input type="text" class="form-control" id="add-tpl-input-name" placeholder="名称" name="name">
                  </div>
                  <div class="form-group">
                    <label for="add-tpl-input-file">模板文件</label>
                    <input type="file" class="form-control" id="add-tpl-input-file" placeholder="模板文件" name="file">
                  </div>
                  <div class="form-group">
                    <label for="add-tpl-input-type">模板类型</label>
                    <div class="form-control">
                    站点模板<input type="radio" value="1" name="type" checked="checked">
                    产品模板<input type="radio" value="2" name="type">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="add-tpl-input-description">备注</label>
                    <textarea type="file" class="form-control" id="add-tpl-input-description" placeholder="备注" name="description"></textarea>
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
        <!-- 添加Tpl结束 -->

        <!-- 修改Tpl -->
        <div class="modal fade" id="updateTplModal" tabindex="-1" role="dialog" aria-labelledby="updateTplModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form>
                <input type="hidden" id="update-tpl-input-id">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="updateTplModalLabel">修改模板</h4>
                </div>
                <div class="modal-body">
                  <div class="form-group">
                    <label for="update-tpl-input-name">名称(*)</label>
                    <input type="text" class="form-control" id="update-tpl-input-name" placeholder="名称" name="name">
                  </div>
                  <div class="form-group">
                    <label for="update-tpl-input-description">备注</label>
                    <textarea type="file" class="form-control" id="update-tpl-input-description" placeholder="备注" name="description"></textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                  <a href="javascript:updateTpl();" class="btn btn-primary">保存</a>
                </div>
              </form>
            </div>
          </div>
        </div>
        <!-- 修改Tpl结束 -->

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

    function showUpdateTplModal(id){
      var $this = $(this);
      $.get("/tpl/"+id,function(data){
        if(data.code === 0){
          $("#update-tpl-input-id").val(data.data.id);
          $("#update-tpl-input-description").val(data.data.desc);
          $("#update-tpl-input-name").val(data.data.name);
          $("#updateTplModal").modal("show");
        }else{
          alert(data.msg);
          $this.parent().parent().fadeOut(function(){
            $this.parent().parent().remove();
          });
        }
      });
    }

    function updateTpl(){
      var id = $("#update-tpl-input-id").val();
      var desc = $("#update-tpl-input-description").val();
      var name = $("#update-tpl-input-name").val();
      $.ajax({
        type: 'PUT',
        url: "/manage/tpl/"+id,
        data:JSON.stringify({
          name:name,
          desc:desc
        }),
        contentType: "application/json; charset=utf-8",
        success: function(data){
          if(data.code === 0){
            alert("修改成功");
            // $("#item-desc-"+id).text(desc);
            // $("#item-name-"+id).text(name);
            // $("#updateTplModal").modal("hide");
            window.location.href="/manage/tpl";
          }else{
            alert(data.msg);
          }
        },
        dataType: "json"
      });
    }

    function deleteTpl(){
      $(".tpl-list-checkbox:checked").each(function(){
        var $this = $(this);
        var id = $this.attr("itemid");
        $.ajax({
          type: 'DELETE',
          url: "/manage/tpl/"+id,
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
      $("#deleteTplModal").modal("hide");
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

    </script>
  </body>
</html>