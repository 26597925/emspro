{x2;globaltpl:ad_header}<body><div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div id="datacontent">				<ol class="breadcrumb">					<li><a href="index.php?{x2;$_route['app']}-master-exams">考试设置</a></li>					<li class="active">{x2;$subject['subjectname']}</li>				</ol>				<div class="settingbar">					<a href="index.php?exam-master-exams-basics&subjectid={x2;$subject['subjectid']}" class="btn btn-default">考场</a>					<a href="index.php?exam-master-exams-questions&subjectid={x2;$subject['subjectid']}" class="btn btn-default">题库</a>					<a href="index.php?exam-master-exams-papers&subjectid={x2;$subject['subjectid']}" class="btn btn-default">试卷</a>					<a href="index.php?exam-master-exams-sections&subjectid={x2;$subject['subjectid']}" class="btn btn-default">章节</a>					<a href="index.php?exam-master-exams-notes&subjectid={x2;$subject['subjectid']}" class="btn btn-primary">笔记</a>					<a href="index.php?exam-master-exams-recyle&subjectid={x2;$subject['subjectid']}" class="btn btn-default">回收站</a>				</div>				<div class="panel panel-default">					<div class="panel-heading">笔记审核</div>					<div class="panel-body">						<table class="table table-bordered">							<thead>								<tr class="info">									<th width="160">发布人</th>									<th width="80">试题ID</th>									<th width="80">状态</th>									<th>内容</th>									<th width="120">操作</th>								</tr>							</thead>							<tbody>								{x2;tree:$notes['data'],note,nid}								<tr>									<td>										{x2;v:note['noteusername']}									</td>									<td>										<a title="查看试题" class="selfmodal" href="javascript:;" url="index.php?exam-master-ajax-questiondetail&questionid={x2;v:note['notequestionid']}" data-target="#modal">                                            {x2;v:note['notequestionid']}										</a>									</td>									<td>                                        {x2;if:v:note['notestatus']}已审核{x2;else}未审核{x2;endif}									</td>									<td>                                        {x2;v:note['notecontent']}									</td>									<td>										<ul class="list-unstyled list-inline">											<li>                                                {x2;if:!v:note['notestatus']}												<a class="ajax" msg="确定要通过审核吗？" href="index.php?exam-master-exams-passnote&noteid={x2;v:note['noteid']}">													审核												</a>                                                {x2;endif}											</li>											<li><a class="confirm" msg="该操作不能恢复，确定吗？" href="index.php?exam-master-exams-delnote&noteid={x2;v:note['noteid']}">删除</a></li>										</ul>									</td>								</tr>								{x2;endtree}							</tbody>						</table>                        {x2;if:$errors['pages']}						<ul class="pagination pull-right">                            {x2;$errors['pages']}						</ul>                        {x2;endif}					</div>				</div>			</div>		</div>	</div></div><div id="modal" class="modal fade">	<div class="modal-dialog">		<div class="modal-content">			<div class="modal-header">				<button aria-hidden="true" class="close" type="button" data-dismiss="modal">×</button>				<h4 id="myModalLabel">					试题详情				</h4>			</div>			<div class="modal-body"></div>			<div class="modal-footer">				<button aria-hidden="true" class="btn btn-primary" data-dismiss="modal">关闭</button>			</div>		</div>	</div></div></body></html>