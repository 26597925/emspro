{x2;globaltpl:ad_header}<body><div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div id="datacontent">				<ol class="breadcrumb">					<li><a href="index.php?{x2;$_route['app']}-master">{x2;$apps[$_route['app']]['appname']}</a></li>					<li class="active">用户列表</li>				</ol>				<div class="panel panel-default">					<div class="panel-heading">用户列表</div>					<div class="panel-body">						<form action="index.php?exam-master-users" method="post" class="form-inline">							<table class="table">								<tr>									<td style="border-top:0px;">										用户ID：									</td>									<td style="border-top:0px;">										<input name="search[userid]" class="form-control" size="15" type="text" class="number" value="{x2;$search['userid']}"/>									</td>									<td style="border-top:0px;">										注册时间：									</td>									<td style="border-top:0px;">										<input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" type="text" name="search[stime]" size="10" id="stime" value="{x2;$search['stime']}"/> - <input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" size="10" type="text" name="search[etime]" id="etime" value="{x2;$search['etime']}"/>									</td>									<td style="border-top:0px;">										用户名：									</td>									<td style="border-top:0px;">										<input class="form-control" name="search[username]" size="15" type="text" value="{x2;$search['username']}"/>									</td>								</tr>								<tr>									<td>										电子邮箱：									</td>									<td>										<input class="form-control" name="search[useremail]" size="15" type="text" value="{x2;$search['useremail']}"/>									</td>									<td>										用户组：									</td>									<td>										<select name="search[groupid]" class="form-control">											<option value="0">不限</option>                                            {x2;tree:$groups,group,gid}											<option value="{x2;v:group['groupid']}"{x2;if:$search['groupid'] == v:group['groupid']} selected{x2;endif}>{x2;v:group['groupname']}</option>                                            {x2;endtree}										</select>									</td>									<td>										<button class="btn btn-primary" type="submit">提交</button>									</td>									<td></td>								</tr>							</table>							<div class="input">								<input type="hidden" value="1" name="search[argsmodel]" />							</div>						</form>						<form action="index.php?user-master-user-batdel" method="post">							<table class="table table-hover table-bordered">								<thead>								<tr class="info">									<th width="80">ID</th>									<th width="160">用户名</th>									<th width="120">姓名</th>									<th width="120">手机号码</th>									<th>电子邮件</th>									<th width="160">用户组</th>									<th width="160">操作</th>								</tr>								</thead>								<tbody>                                {x2;tree:$users['data'],user,uid}								<tr>									<td>{x2;v:user['userid']}</td>									<td>{x2;v:user['username']}</td>									<td>{x2;v:user['usertruename']}</td>									<td>{x2;v:user['userphone']}</td>									<td>{x2;v:user['useremail']}</td>									<td>{x2;$groups[v:user['usergroupcode']]['groupname']}</td>									<td>										<ul class="list-unstyled list-inline">											<li><a href="index.php?user-master-users-modify&userid={x2;v:user['userid']}&page={x2;$page}{x2;$u}" title="修改">修改</a></li>                                            {x2;if:v:user['userid'] != $_user['userid']}											<li><a msg="删除后不可恢复，您确定要进行此操作吗？" class="confirm" href="index.php?user-master-user-del&userid={x2;v:user['userid']}&page={x2;$page}{x2;$u}" title="删除">删除</a></li>                                            {x2;endif}										</ul>									</td>								</tr>                                {x2;endtree}								</tbody>							</table>							<div class="form-group">								<div class="controls">									<input type="hidden" name="action" value="delete"/>									{x2;tree:$search,arg,sid}									<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>                                    {x2;endtree}									<button class="btn btn-primary" type="submit">删除</button>								</div>							</div>						</form>						{x2;if:$users['pages']}						<ul class="pagination pull-right">                            {x2;$users['pages']}						</ul>						{x2;endif}					</div>				</div>			</div>		</div>	</div></div></body></html>