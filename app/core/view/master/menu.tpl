<ul class="list-group">	<li class="list-group-item {x2;if:$_route['method'] == 'index'} active{x2;endif}">		{x2;if:$_route['method'] == 'index'}首页		{x2;else}		<a href="index.php?core-master">首页</a>		{x2;endif}	</li>	<li class="list-group-item hide {x2;if:$_route['method'] == 'apps'}active{x2;endif}">		{x2;if:$_route['method'] == 'apps'}模块列表		{x2;else}		<a href="index.php?core-master-apps">模块列表</a>		{x2;endif}	</li>	<li class="list-group-item">		<a href="http://www.phpems.net">官网支持</a>	</li></ul>