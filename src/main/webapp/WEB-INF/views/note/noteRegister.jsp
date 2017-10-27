<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-lg-3"></div>
<div class="content col-lg-6">
	<div class="main-content">
		<div class="row">
			<div class="col-md-12">
				<!-- BASIC INPUT -->
				<div class="widget">
					<div class="widget-content">
						<div class="form-horizontal">
							<div class="form-group">
								<label class="col-md-1 control-label">Title</label>
								<div class="col-md-11">
									<input type="text" class="form-control" placeholder="Title">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-1 control-label">Category</label>
								<div class="col-md-11">
									<select name="select2" id="select2" class="select2">
										<c:forEach var="list" items="${categoryList}">
											<option value="${list.seq}">${list.type}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="form-horizontal">
							<div style="margin-bottom: -10px;">
							<jsp:include page="/WEB-INF/views/note/editor.jsp" flush="true"></jsp:include>
							<script>
							if('${board!=null}'=='true') Editor.modify({'content': '${board.board_content}'});
							</script>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="widget-footer" style="text-align: right;">
					<button type="button" class="btn btn-default note-back-btn" style="border-radius: 4px;"><i class="fa fa-arrow-left"></i> Back</button>
					<button type="button" class="btn btn-success note-save-btn" style="border-radius: 4px;"><i class="fa fa-floppy-o"></i> Save</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-lg-3"></div>

<form id="backForm" name="backForm" method="post" action="/note/main">
</form>

<script>
$(document).ready(function() {
	$(".note-back-btn").on('click',function(){
		$("#backForm").submit();
	});
	
	$(".note-save-btn").on('click', function(){
		console.log(CKEDITOR.instances.noteEditor.getData());
	});
});
  
</script>