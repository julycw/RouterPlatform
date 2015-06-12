<div class="row" style="background-color: beige;">
	<div class="col-sm-12 col-xs-12" style="padding:25px;">
		<div style="float:left;width:90%;box-shadow:2px 2px 5px silver;padding-bottom: 20px;background-color:white;">
		<img src="{{.article.FaceImagePath}}" class="img-responsive">
		</div>
		<div style="float:right;width:90%;box-shadow:2px 2px 10px gray;background-color:white;position:relative;top:-20px;padding:35px 10px 15px 10px;">
		
		{{if .article.Description}}
		<p style="text-indent:2em;">{{.article.Description}}</p>
		{{else}}
      	<p>店家尚未填写任何内容？赶紧<a href="#addFeedbackModal" data-toggle="modal">通知一下</a>他吧！</p>
		{{end}}
		</div>
	</div>
</div>
