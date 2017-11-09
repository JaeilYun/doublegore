<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="col-lg-6">
	<div class="content">
		<div class="main-content" style="padding: 20px 3px 10px 3px;">
			<!-- WIDGET QUICK NOTE -->
			<div class="test">
			<div class="widget widget-quick-note quick-note-create">
				<div class="widget-content">
					<form id="memoForm" class="form-horizontal" role="form">
						<textarea class="form-control noteContent" rows="1" cols="30" placeholder="Add quick note"></textarea>
					</form>
				</div>
				<div class="widget-footer">
					<div class="btn-group">
						<button type="button" class=" btn btn-clean note-view-menu-btn" style="border-radius: 10px; text-decoration:none !important;color: #bbb;font-weight: 600;">사진</button>
					</div>
					<div class="btn-group" style="float: right;">
						<button type="button" class=" btn btn-clean note-view-delete-btn" style="border-radius: 10px; text-decoration:none !important;color: rgba(219, 56, 51, 0.5);font-weight: 600;">초기화</button>
						<button type="button" class=" btn btn-clean note-view-edit-btn" style="border-radius: 10px; text-decoration:none !important;color: rgba(75, 168, 75, 0.5);font-weight: 600;">저장</button>
					</div>
				</div>
			</div>
			</div>
			<!-- END WIDGET QUICK NOTE -->
			<div class="project-section activity">
				<h3></h3>
				<ul class="list-unstyled activity-list">
					<li data-toggle="collapse" data-parent="#accordion2" href="#collapseOne2">
						<!-- <i class="fa fa-check activity-icon pull-left icon-success"></i> -->
						<div>
							<p>All project tasks are on schedule <span class="timestamp" style="float: right; margin-right: 10px;">1 minutes ago</span></p>
							<div id="collapseOne2" class="panel-collapse collapse">
								<div style="padding: 5px;">Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo.</div>
							</div>
						</div>
					</li>
					<li data-toggle="collapse" data-parent="#accordion2" href="#collapseOne2">
						<!-- <i class="fa fa-check activity-icon pull-left icon-success"></i> -->
						<div>
							<p>All project tasks are on schedule <span class="timestamp" style="float: right; margin-right: 10px;">1 minutes ago</span></p>
							<div id="collapseOne2" class="panel-collapse collapse">
								<div style="padding: 5px;">Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo.</div>
							</div>
						</div>
					</li>
					<li data-toggle="collapse" data-parent="#accordion2" href="#collapseOne2">
						<!-- <i class="fa fa-check activity-icon pull-left icon-success"></i> -->
						<div>
							<p>All project tasks are on schedule <span class="timestamp" style="float: right; margin-right: 10px;">1 minutes ago</span></p>
							<div id="collapseOne2" class="panel-collapse collapse">
								<div style="padding: 5px;">Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo.</div>
							</div>
						</div>
					</li>
					<li>
						<i class="fa fa-file-word-o activity-icon pull-left"></i>
						<p>New file <a href="#">Project Proposalv2.docx</a> has been uploaded by <a href="#">Antonius</a> <span class="timestamp">2 days ago</span></p>
					</li>
					<li>
						<i class="fa fa-print activity-icon pull-left icon-warning"></i>
						<p>You have <a href="#">pending documents</a> on the printer server <span class="timestamp">2 days ago</span></p>
					</li>
					<li>
						<i class="fa fa-flag activity-icon pull-left icon-success"></i>
						<p>Project: <a href="#">Phase 1</a> has been flagged as completed by <a href="#">Antonius</a> <span class="timestamp">3 days ago</span></p>
					</li>
				</ul>
				<button type="button" class="btn btn-link center-block"><i class="fa fa-refresh"></i> Load more</button>
			</div>
		</div>
	</div>
</div>
<!-- END CONTENT WRAPPER -->
<div class="col-lg-3"></div>

<script>
    $(document).ready(function(){
    	$(".memo-save").on('click', function(){
    		$.ajax({
                url: '/memo/insertMemo',
                data: {
                    "content" : $(".noteContent").text()
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                	
                }
    		});
    	});
    	
    });
</script>