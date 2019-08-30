{x2;include:header}<body>{x2;include:nav}<div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div class="col-xs-2 leftmenu">				{x2;include:menu}			</div>			<div class="col-xs-10" id="datacontent">				<ol class="breadcrumb">					<li><a href="index.php?{x2;$_route['app']}-master">{x2;$apps[$_route['app']]['appname']}</a></li>					<li><a href="index.php?{x2;$_route['app']}-master-model">模型管理</a></li>					<li class="active">修改模型</li>				</ol>				<div class="panel panel-default">					<div class="panel-heading">修改模型</div>					<div class="panel-body">						<form action="index.php?database-master-model-modify" method="post" class="form-horizontal">							<fieldset>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">模型代码：</label>									<div class="col-sm-6">										{x2;$model['modelintro']}（模型代码不可更改）									</div>								</div>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">模型名称：</label>									<div class="col-sm-6">										<input class="form-control" name="args[modelname]" type="text" size="20" value="{x2;$model['modelname']}" alt="请输入模型名称" needle="needle" msg="请输入模型名称"/>									</div>								</div>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">数据库：</label>									<div class="col-sm-10 form-inline">										<select name="args[modeldb]" needle="needle" refUrl="index.php?database-master-model-gettables&dbid={value}" class="form-control combox" target="modeltable">											<option value="">请选择数据库</option>                                            {x2;tree:$databases,db,did}											<option value="{x2;v:key}"{x2;if:$model['modeldb'] == v:key} selected{x2;endif}>{x2;v:db['host']}/{x2;v:db['name']}</option>                                            {x2;endtree}										</select>									</div>								</div>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">绑定表：</label>									<div class="col-sm-10 form-inline">										<select name="args[modeltable]" needle="needle" class="form-control" id="modeltable">											<option value="">请先选择数据库</option>                                            {x2;tree:$tables,table,tid}											{x2;eval: v:table = current(v:table)}											<option value="{x2;v:table}"{x2;if:$model['modeltable'] == v:table} selected{x2;endif}>{x2;v:table}</option>                                            {x2;endtree}										</select>									</div>								</div>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">模块：</label>									<div class="col-sm-10 form-inline">										<select name="args[modelapp]" needle="needle" class="form-control">											<option value="">请选择模块</option>											{x2;tree:$apps,app,aid}											<option value="{x2;v:app['appcode']}"{x2;if:$model['modelapp'] == v:app['appcode']} selected{x2;endif}>{x2;v:app['appname']}</option>											{x2;endtree}										</select>									</div>								</div>								<div class="form-group">									<label for="questype" class="control-label col-sm-2">模型描述：</label>									<div class="col-sm-6">										<input class="form-control" name="args[modelintro]" value="{x2;$model['modelintro']}" type="text" size="30" needle="needle" alt="请输入模型描述" />									</div>								</div>								<div class="form-group">									<label for="questchoice" class="control-label col-sm-2"></label>									<div class="col-sm-9">										<button class="btn btn-primary" type="submit">提交</button>										<input type="hidden" name="modifymodel" value="1"/>										<input type="hidden" name="modelcode" value="{x2;$model['modelcode']}"/>                                        {x2;tree:$search,arg,aid}										<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>                                        {x2;endtree}									</div>								</div>							</fieldset>						</form>					</div>				</div>			</div>		</div>	</div></div>{x2;include:footer}</body></html>