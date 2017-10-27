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
								<textarea name="noteEditor" id="noteEditor">
								</textarea>
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
	CKEDITOR.replace('noteEditor',{
		toolbar: [
			{ name: 'document', items: [ 'Print' ] },
			{ name: 'clipboard', items: [ 'Undo', 'Redo' ] },
			{ name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
			{ name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
			{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
			{ name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
			{ name: 'links', items: [ 'Link', 'Unlink' ] },
			{ name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
			{ name: 'insert', items: [ 'Image', 'Table' ] },
			{ name: 'tools', items: [ 'Maximize' ] },
			{ name: 'editing', items: [ 'Scayt' ] }
		],
		customConfig: '',
		disallowedContent: 'img{width,height,float}',
		extraAllowedContent: 'img[width,height,align]',
		extraPlugins: 'tableresize,uploadimage,uploadfile,imageresize',
		removePlugins: 'elementspath',
		height: 400,
		bodyClass: 'document-editor',
		format_tags: 'p;h1;h2;h3;pre',
		removeDialogTabs: 'image:advanced;link:advanced',
		stylesSet: [
			/* Inline Styles */
			{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
			{ name: 'Cited Work', element: 'cite' },
			{ name: 'Inline Quotation', element: 'q' },
			/* Object Styles */
			{
				name: 'Special Container',
				element: 'div',
				styles: {
					padding: '5px 10px',
					background: '#eee',
					border: '1px solid #ccc'
				}
			},
			{
				name: 'Compact table',
				element: 'table',
				attributes: {
					cellpadding: '5',
					cellspacing: '0',
					border: '1',
					bordercolor: '#ccc'
				},
				styles: {
					'border-collapse': 'collapse'
				}
			},
			{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
			{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
		],
		filebrowserImageUploadUrl: '${contextRoot}/note/noteImageUpload',
		uploadUrl: '${contextRoot}/note/noteImageUpload'
	});
	
	CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
      
        switch (dialogName) {
            case 'image': //Image Properties dialog
                //dialogDefinition.removeContents('info');
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                break;
        }
    });
	
	$(".note-save-btn").on('click', function(){
		console.log(CKEDITOR.instances.noteEditor.getData());
	});
});
  
</script>