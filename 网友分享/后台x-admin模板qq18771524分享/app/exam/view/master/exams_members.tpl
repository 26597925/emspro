{x2;if:!$_userhash}{x2;globaltpl:ad_header}<body><div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div id="datacontent">				{x2;endif}				<ol class="breadcrumb">					<li><a href="index.php?{x2;$_route['app']}-master-exams">考试管理</a></li>					<li><a href="index.php?{x2;$_route['app']}-master-exams-basics&subjectid={x2;$subject['subjectid']}">{x2;$subject['subjectname']}</a></li>					<li class="active">{x2;$basic['basic']}</li>				</ol>				<div class="panel panel-default">					<div class="panel-heading">						考场人员						<a class="pull-right" href="index.php?exam-master-exams-addmember&basicid={x2;$basic['basicid']}">增加</a>					</div>					<div class="panel-body">						<form action="index.php?exam-master-exams-members&basicid={x2;$basic['basicid']}" method="post" class="form-inline">							<table class="table">								<thead>									<tr>										<td>											用户名：										</td>										<td>											<input class="form-control" name="search[username]" size="15" type="text" value="{x2;$search['username']}"/>										</td>										<td>											开通时间：										</td>										<td>											<input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" type="text" name="search[stime]" size="10" id="stime" value="{x2;$search['stime']}"/> - <input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" size="10" type="text" name="search[etime]" id="etime" value="{x2;$search['etime']}"/>										</td>										<td>											<button class="btn btn-primary" type="submit">搜索</button>											<input type="hidden" value="1" name="search[argsmodel]" />										</td>									</tr>								</thead>							</table>						</form>						<table class="table table-hover table-bordered">							<thead>							<tr class="info">								<th>ID</th>								<th>用户名</th>								<th>姓名</th>								<th>角色</th>								<th>开通时间</th>								<th>到期时间</th>								<th>操作</th>							</tr>							</thead>							<tbody>                            {x2;tree:$members['data'],user,uid}							<tr>								<td width="80">{x2;v:user['userid']}</td>								<td width="160">{x2;v:user['username']}</td>								<td width="160">{x2;v:user['userrealname']}</td>								<td width="180">{x2;$groups[v:user['usergroupcode']]['groupname']}</td>								<td width="180">{x2;v:user['obtime']}</td>								<td>{x2;v:user['obendtime']}</td>								<td width="80">									<ul class="list-unstyled list-inline">										<li>											<a class="confirm" href="index.php?exam-master-exams-removemember&obid={x2;v:user['obid']}{x2;$u}" title="移除">移除</a>										</li>									</ul>								</td>							</tr>                            {x2;endtree}							</tbody>						</table>                        {x2;if:$members['pages']}						<ul class="pagination pull-right">                            {x2;$members['pages']}						</ul>                        {x2;endif}					</div>				</div>                {x2;if:!$_userhash}			</div>		</div>	</div></div></body></html>{x2;endif}