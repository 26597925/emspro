{x2;if:!$_userhash}
{x2;include:header}
<div class="pages">
    {x2;endif}
		<div class="pages-tabs">
			<div class="pages-header">
				<a class="col-xs-2" href="javascript:history.back();"><div class="text-center">
					<i class="glyphicon glyphicon glyphicon-menu-left"></i>
				</div></a>
				<a class="col-xs-8 active">
					<div class="text-center">{x2;$basic['basic']}</div>
				</a>
				<a class="col-xs-2">
					<div class="text-center">
						<i class="glyphicon glyphicon-option-horizontal"></i>
					</div>
				</a>
			</div>
			<div class="pages-content nofooter">
				<div class="pages-box">
					<div class="page-ele margin">
						<ul class="listmenu">
                            {x2;eval: v:number = 0;}
							{x2;tree:$basic['basicpoints'][$sectionid],point,pid}
							{x2;if:$wrong[v:point]}
							<li class="small">
								<a class="ajax" href="index.php?exam-mobile-favor-wrongpaper&pointid={x2;v:point}" data-page="yes" data-title="{x2;$points[v:point]['pointname']}">
									<div class="col-xs-11">
										<p class="title">
											{x2;$points[v:point]['pointname']}
										</p>
										<div class="clear">
											共{x2;$wrong[v:point]}道错题
                                            {x2;eval: v:number += $wrong[v:point];}
										</div>
									</div>
									<div class="col-xs-1">
										<i class="glyphicon glyphicon-menu-right pull-right"></i>
									</div>
								</a>
							</li>
							{x2;endif}
							{x2;endtree}
                            {x2;if:!v:number}
							<li class="small">您没有错题</li>
                            {x2;endif}
						</ul>
					</div>
				</div>
			</div>
		</div>
    {x2;if:!$_userhash}
</div>
{x2;include:footer}
{x2;endif}