﻿


{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">中转规则管理</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-md-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>系统中所有的中转规则。</p>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$rules->render()}
						<table class="table">
						    <tr>
							<th>操作</th>
							<th>ID</th>
							<th>用户ID</th>
							<th>用户名</th>
							<th>起源节点</th>
							<th>目标节点</th>
							<th>端口</th>
							<th>优先级</th>
							
							</tr>
							{foreach $rules as $rule}
								<tr>
								<td>
									<a class="btn btn-brand" href="/admin/relay/{$rule->id}/edit">编辑</a>
									<a class="btn btn-brand-accent" id="delete" value="{$rule->id}" href="javascript:void(0);" onClick="delete_modal_show('{$rule->id}')">删除</a>
								</td>
								<td>#{$rule->id}</td>
								<td>{$rule->user_id}</td>
								<td>{$rule->User()->user_name}</td>
								{if $rule->source_node_id == 0}
									<td>所有节点</td>
								{else}
									<td>{$rule->Source_Node()->name}</td>
								{/if}
								<td>{$rule->Dist_Node()->name}</td>
								<td>{$rule->port}</td>
								<td>{$rule->priority}</td>
						        </tr>
						    {/foreach}
						</table>
						{$rules->render()}
					</div>
					
					<div class="fbtn-container">
						<div class="fbtn-inner">
							<a class="fbtn fbtn-lg fbtn-brand-accent waves-attach waves-circle waves-light" href="/admin/relay/create">+</a>
							
						</div>
					</div>
					
					<div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">确认要删除？</h2>
								</div>
								<div class="modal-inner">
									<p>请您确认。</p>
								</div>
								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand-accent waves-attach waves-effect" data-dismiss="modal" type="button">取消</button><button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal" id="delete_input" type="button">确定</button></p>
								</div>
							</div>
						</div>
					</div>
					
					{include file='dialog.tpl'}

							
			</div>
			
			
			
		</div>
	</main>






{include file='admin/footer.tpl'}




<script>
function delete_modal_show(id) {
	deleteid=id;
	$("#delete_modal").modal();
}


$(document).ready(function(){
	function delete_id(){
		$.ajax({
			type:"DELETE",
			url:"/admin/relay",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
				}else{
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error:function(jqXHR){
				$("#result").modal();
				$("#msg").html(data.msg+"  发生错误了。");
			}
		});
	}
	$("#delete_input").click(function(){
		delete_id();
	});
})
	
</script>







