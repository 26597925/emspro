{x2;globaltpl:ad_header}<body><div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div id="datacontent">				<div class="panel panel-default">					<div class="panel-heading">						模型管理						<a class="pull-right" href="index.php?database-master-model-add">增加</a>					</div>					<div class="panel-body">						<table class="table table-striped table-bordered">							<tr>								<th width="120">模型代码</th>								<th width="120">模型名</th>								<th width="120">模块</th>								<th width="120">所在库</th>								<th width="120">关联表</th>								<th>备注</th>								<th width="180">操作</th>							</tr>                            {x2;if:$models['number']}							{x2;tree:$models['data'],model,mid}							<tr>								<td>{x2;v:model['modelcode']}</td>								<td>{x2;v:model['modelname']}</td>								<td>{x2;v:model['modelapp']}</td>								<td>{x2;v:model['modeldb']}</td>								<td>{x2;v:model['modeltable']}</td>								<td>{x2;v:model['modelintro']}</td>								<td>									<ul class="list-unstyled list-inline">										<li><a href="index.php?{x2;$_route['app']}-master-model-preview&modelcode={x2;v:model['modelcode']}">预览</a></li>										<li><a href="index.php?{x2;$_route['app']}-master-model-properties&modelcode={x2;v:model['modelcode']}">属性</a></li>										<li><a href="index.php?{x2;$_route['app']}-master-model-modify&modelcode={x2;v:model['modelcode']}">修改</a></li>										<li><a class="confirm" href="index.php?{x2;$_route['app']}-master-model-del&modelcode={x2;v:model['modelcode']}">删除</a></li>									</ul>								</td>							</tr>							{x2;endtree}							{x2;else}							<tr>								<td colspan="7">当前没有模型。</td>							</tr>							{x2;endif}						</table>						{x2;if:$models['pages']}						<ul class="pagination pull-right">                            {x2;$models['pages']}						</ul>                        {x2;endif}					</div>				</div>			</div>		</div>	</div></div></body></html>