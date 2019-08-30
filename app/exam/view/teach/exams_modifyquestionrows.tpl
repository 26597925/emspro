{x2;include:header}<body>{x2;include:nav}<div class="container-fluid">	<div class="row-fluid">		<div class="pep">			<div class="col-xs-2 leftmenu">                {x2;include:menu}			</div>			<div class="col-xs-10" id="datacontent">				<ol class="breadcrumb">					<li><a href="index.php?{x2;$_route['app']}-teach">教师管理</a></li>					<li><a href="index.php?{x2;$_route['app']}-teach-exams">考试管理</a></li>					<li><a href="index.php?{x2;$_route['app']}-teach-exams-questionrows">{x2;$subject['subjectname']}</a></li>					<li class="active">修改题帽题</li>				</ol>				<div class="panel panel-default">					<div class="panel-heading">修改题帽题</div>					<div class="panel-body">						<form action="index.php?exam-teach-exams-modifyquestionrows" method="post" class="form-horizontal">							<fieldset>								<div class="form-group">									<label class="control-label col-sm-2">知识点：</label>									<div class="col-sm-9">										<div class="btn-toolbar" id="questionpointsid">                                            {x2;tree:$questionrows['qrpoints'],point,pid}											<span class="btn-group">												<span type="button" class="btn btn-primary">{x2;$points[v:point]['pointname']}</span>												<input type="hidden" name="args[questionpoints][]" value="{x2;v:point}">												<span class="btn btn-danger tool" onclick="javascript:$(this).parent().remove();"><i class="glyphicon glyphicon-remove"></i></span>											</span>                                            {x2;endif}										</div>										<span class="help-block">请在下方选择知识点，并点击选定</span>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2"></label>									<div class="col-sm-9 form-inline">										<select class="combox form-control" id="isectionselect" target="ipointselect" refUrl="index.php?exam-teach-ajax-getpointsbysectionid&sectionid={value}">											<option value="0">选择章节</option>                                            {x2;tree:$sections,section,sid}											<option value="{x2;v:section['sectionid']}">{x2;v:section['sectionname']}</option>                                            {x2;endtree}										</select>										<select class="combox form-control" id="ipointselect">											<option value="0">选择知识点</option>										</select>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2"></label>									<div class="col-sm-9 form-inline">										<input type="button" class="btn btn-primary" value="选定" onclick="javascript:setKnowsList('questionpointsid','ipointselect','+');"/>										<input type="button" class="btn btn-danger" value="清除" onclick="javascript:setKnowsList('questionpointsid','ipointselect','-');"/>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2">题型：</label>									<div class="col-sm-3">										<select needle="needle" id="questypeselector" msg="您必须为要添加的试题选择一种题型" name="args[qrtype]" class="form-control" onchange="javascript:setAnswerHtml($(this).find('option:selected').attr('rel'),'answerbox');">                                            {x2;tree:$questypes,questype,qid}											<option rel="{x2;if:v:questype['questsort']}0{x2;else}{x2;v:questype['questchoice']}{x2;endif}" value="{x2;v:questype['questcode']}"{x2;if:v:questype['questcode'] == $questionrows['qrtype']} selected{x2;endif}>{x2;v:questype['questype']}</option>                                            {x2;endtree}										</select>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2">题干：</label>									<div class="col-sm-10">										<textarea class="ckeditor" needle="needle" msg="请填写题干" name="args[qrquestion]" id="qrquestion">{x2;$questionrows['qrquestion']}</textarea>										<span class="help-block">需要填空处请以()表示。</span>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2">难度：</label>									<div class="col-sm-3">										<select class="form-control" name="args[qrlevel]" needle="needle" msg="您必须为要添加的试题设置一个难度">											<option value="1"{x2;if:$questionrows['qrlevel']==1} selected{x2;endif}>易</option>											<option value="2"{x2;if:$questionrows['qrlevel']==2} selected{x2;endif}>中</option>											<option value="3"{x2;if:$questionrows['qrlevel']==3} selected{x2;endif}>难</option>										</select>									</div>								</div>								<div class="form-group">									<label class="control-label col-sm-2"></label>									<div class="col-sm-9">										<button class="btn btn-primary" type="submit">提交</button>										<input type="hidden" name="page" value="{x2;$page}"/>										<input type="hidden" name="qrid" value="{x2;$questionrows['qrid']}"/>										<input type="hidden" name="modifyquestionrows" value="1"/>                                        {x2;tree:$search,arg,aid}										<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>                                        {x2;endtree}									</div>								</div>						</form>					</div>				</div>			</div>		</div>	</div></div><script>$(function(){	setAnswerHtml($('#questypeselector').find('option:selected').attr('rel'),'answerbox');});</script>{x2;include:footer}</body></html>