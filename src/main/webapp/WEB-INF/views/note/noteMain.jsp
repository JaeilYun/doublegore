<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="col-lg-6">
	<div class="content">
		<!-- 메인화면 시작 -->
		<jsp:include page="/WEB-INF/views/note/noteList.jsp" flush="true"></jsp:include>
		<!-- 메인화면 끝 -->
		
		<!-- 상세화면 시작 -->
		<jsp:include page="/WEB-INF/views/note/noteView.jsp" flush="true"></jsp:include>
		<!-- 상세화면 끝 -->
		
		<!-- 등록화면 시작 -->
		<jsp:include page="/WEB-INF/views/note/noteRegister.jsp" flush="true"></jsp:include>
		<!-- 등록화면 끝 -->
	</div>
</div>
<!-- END CONTENT WRAPPER -->
<div class="col-lg-3"></div>

<button class="btn btn-primary btn-lg setting-modal-btn" data-toggle="modal" data-target="#settingModal" style="display: none;"></button>
<div class="modal fade" id="settingModal" tabindex="-1" role="dialog" aria-labelledby="settingModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Category settings</h4>
			</div>
			<div class="modal-body category-modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="input-appendable-wrapper setting-contents">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onClick="categoryReload();"><i class="fa fa-refresh"></i> Refresh</button>
				<button type="button" class="btn btn-custom-primary" onClick="settingsSave();"><i class="fa fa-check-circle"></i> Save changes</button>
				<button type="button" class="btn btn-default setting-modal" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
			</div>
		</div>
	</div>
</div>

<!-- 메인화면 이동 -->
<form id="mainForm" name="mainForm" method="post" action="/note/main">
</form>

<input type="hidden" id="page" name="page" value="${noteList.getNumber()}">
<input type="hidden" id="size" name="size" value="${noteList.getSize()}">
<input type="hidden" id="category" name="category" value="ALL">

<script>
    $(document).ready(function(){
    	//페이징 처리
    	init();
    	
    	//설정버튼 클릭
    	$(".setting-btn").on('click', function(e) {
    		e.preventDefault();
    		categoryReload();
    		$(".setting-modal-btn").click();
    	});
    	
    	//카테고리 설정 화면에서 +버튼 눌렀을 시 카테고리 추가
    	addCategory = function() {
    		$("#newCategory").val($("#newCategory").val());
    		if($("#newCategory").val().length > 0) {
	    		var str = "";
	    		str += '<div class="input-group input-group-appendable">';
	 			str += 	   '<input autocomplete="off" class="input form-control" id="new" type="text" value="'+$("#newCategory").val()+'">';
	 			str +=     '<span class="input-group-btn">';
	 			str +=         '<button id="btn1" class="btn btn-danger" type="button" onClick="removeCategory(this);"><i class="fa fa-minus" aria-hidden="true"></i></button>';
	 			str +=     '</span>';
	 			str += '</div>';
	 			$(".setting-contents").children(":last").before(str);
	 			$("#newCategory").val("");
    		}
    	};
    	
    	//카테고리 리스트 다시 불러오기
    	categoryReload = function() {
    		$.ajax({
                url: '/note/selectNoteCategory',
                type: 'GET',
                success: function (result) {
                	$(".setting-contents").empty();
             		var str = "";
                	for(var i = 0; i < result.length; i++) {
             			str += '<div class="input-group input-group-appendable">';
             			str += 	   '<input autocomplete="off" class="input form-control test" id="'+result[i].seq+'" type="text" value="'+result[i].type+'">';
             			str +=     '<span class="input-group-btn">';
             			str +=         '<button class="btn btn-danger" type="button" onClick="removeCategory(this);"><i class="fa fa-minus" aria-hidden="true"></i></button>';
             			str +=     '</span>';
             			str += '</div>';
             		}
                	str += '<div class="input-group input-group-appendable">';
         			str += 	   '<input autocomplete="off" id="newCategory" class="input form-control" type="text" value="">';
         			str +=     '<span class="input-group-btn">';
         			str +=         '<button class="btn btn-primary" type="button" onClick="addCategory();"><i class="fa fa-plus" aria-hidden="true"></i></button>';
         			str +=     '</span>';
         			str += '</div>';

         			$(".setting-contents").append(str);
                }
    		});
    	}
    	
    	//카테고리 설정 변경 저장
    	settingsSave = function() {
			var categoryArr = [];
    		$(".setting-contents").children(".input-group-appendable").each(function(){
    			var subNode = $(this).children().first();
    			var nodeId = subNode.attr('id');
    			if(nodeId == 'new') {
    				categoryArr.push(nodeId + "," + subNode.attr('value'));
    			} else {
    				categoryArr.push(nodeId + "," + document.getElementById(nodeId).value);
    			}
    		});
    		$.ajax({
                url: '/note/updateCategory',
                data: {
                    "categoryArr" : categoryArr
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                	init(0);
                	$(".setting-modal").click();
                }
            });
    	}
    	
    	//카테고리 모달화면에서 바탕 클릭시 에러 메시지 제거
    	$(".category-modal-body").on('click', function(){
    		$(".category-error-message").remove();
    		$(".input-group-appendable").removeClass("has-error");
    	});
    	
    });

    //카테고리 삭제
    removeCategory = function(val){
    	if($(val).parents(".input-group-appendable").find("input").attr('id') == 'new') {
    		$(val).parents(".input-group-appendable").remove();
    	} else {
    		$.ajax({
                url: '/note/checkNoteWhenCategoryDelete',
                data: {
                    "seq" : $(val).parents(".input-group-appendable").find("input").attr('id')
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                	if(result > 0) {
                		$('<label class="has-error category-error-message" style="color: #a94442" for="inputError2">카테고리에 해당하는 게시글이 존재합니다.</label>').insertBefore($(val).parents(".input-group-appendable"));
                		$(val).parents(".input-group-appendable").addClass("has-error");
                		$(val).parents(".input-group-appendable").find("input").focus();
                		$(val).parents(".input-group-appendable").find("input").select();
                	} else {
                		$(val).parents(".input-group-appendable").remove();
                	}
                }
            });
    	}
	}
	
    //페이징 처리
	init = function(page, category) {
		$.ajax({
            url: '/note/search',
            data: {
                "page" : (typeof page == 'undefined') ? "0" : page,
                "size" : "10",
                "category" : $("#category").val()
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	var noteList = result.noteList;
            	var categoryList = result.categoryList;
            	
            	var categoryStr = "";
            	$(".category-list").empty();
            	categoryStr += '<option value="ALL">전체</option>';
            	for(var i = 0; i < categoryList.length; i++) {
            		if(categoryList[i].seq == $("#category").val()) {
            			categoryStr += '<option value="'+categoryList[i].seq+'" selected="selected">'+categoryList[i].type+'</option>';
            		} else {
            			categoryStr += '<option value="'+categoryList[i].seq+'">'+categoryList[i].type+'</option>';
            		}
            	}
            	$(".category-list").append(categoryStr);
            	
            	if(noteList.content.length == 0) {
            		if(noteList.number == 0) {
            			var pagingStr = "";
                		$(".pagination").empty();
                		$("#page").val(noteList.number);
                		pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-left"></i></a></li>';
                		pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-right"></i></a></li>';
                		$(".pagination").append(pagingStr);
                		$(".noteList").empty();
                		$(".pagination").empty();
            		} else {
                		init((noteList.number-1) < 0 ? 0 : (noteList.number-1));
            		}
            	} else {
            		var noteStr = "";
            		var pagingStr = "";
            		$(".noteList").empty();
            		$(".pagination").empty();
            		$("#page").val(noteList.number);
            		
            		noteStr += '<div style="border-bottom:1px solid #ddd"></div>';
            		for(var i = 0; i < noteList.content.length; i++){
            			noteStr += '<a href="javascript:void(0);" onClick="noteView('+noteList.content[i].seq+')" style="text-decoration:none !important;"><div class="note-list-hover" style="padding: 8px;border-right: 1px solid white; border-left: 1px solid white;">';
            			noteStr += '<div class="widget-content" style="padding-bottom:15px;">';
            			noteStr += '<h3 style="font-weight: 500;color:#555 !important;padding-bottom: 10px;">'+noteList.content[i].title+'</h3>';
            			noteStr += '<div style="color:#555 !important;">'+noteList.content[i].contents+'</div>';
            			noteStr += '<div>';
            			noteStr += '<span style="color: #1D92AF !important;font-weight: 500;">'+noteList.content[i].noteCategory.type+'</span><span class="timestamp pull-right" style="color: #bbb;">'+noteList.content[i].updatedDate+'</span>';
            			noteStr += '</div></div></div></a><div style="border-bottom:1px solid #ddd"></div>';
            		}
            		$(".noteList").append(noteStr);
            		
            		var startPage = (noteList.number < 5) ? 1 : noteList.number-3;
            		var endPage = (noteList.totalPages < noteList.number+6) ? noteList.totalPages : noteList.number+5;
            		var prePage = (noteList.number < 5) ? 0 : noteList.number-5;
            		var postPage = (noteList.totalPages < noteList.number+6) ? noteList.totalPages-1 : noteList.number+5

        			if(noteList.first == true) {
        				pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-left"></i></a></li>';
        			} else {
        				pagingStr += '<li><a href="#" onClick="init('+prePage+');"><i class="fa fa-chevron-left"></i></a></li>';
        			}
            		for(var i = startPage; i < endPage+1; i++) {
            			if(i == noteList.number+1) {
            				pagingStr += '<li class="active"><a href="#" onClick="return false">'+(i)+'</a></li>';
            			} else {
            				pagingStr += '<li><a href="#" onClick="init('+(i-1)+');">'+(i)+'</a></li>';
            			}
            		}
            		if(noteList.last == true) {
        				pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-right"></i></a></li>';
        			} else {
        				pagingStr += '<li><a href="#" onClick="init('+postPage+');"><i class="fa fa-chevron-right"></i></a></li>';
        			}
            		$(".pagination").append(pagingStr);
            	}
            }
        });
	}
	
    //노트 상세화면 보기
	noteView = function(seq){
		$.ajax({
            url: '/note/selectNote',
            data: {
                "seq" : seq
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	$("#seq").val(result.note.seq);
            	$(".note-view-category").text(result.note.noteCategory.type);
            	$(".note-view-title").text(result.note.title);
            	$(".note-view-date").text(result.note.updatedDate);
            	$(".note-view-contents").html(result.note.contents);
        		$(".note-list-div").css("display","none");
        		$(".note-view-div").css("display","block");
        		$(".note-register-div").css("display","none");
            }
		});
	}
	
    //메인화면 이동
    main = function(){
    	$("#mainForm").submit();
    }
	
    //노트 삭제
	$(".note-view-delete").on('click', function(){
		$.ajax({
            url: '/note/deleteNote',
            data: {
                "seq" : $("#seq").val(),
                "page" : $("#page").val()
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	init(result);
            	$(".note-list-div").css("display","block");
        		$(".note-view-div").css("display","none");
        		$(".note-register-div").css("display","none");
            }
		});
	});
    
    //글쓰기 버튼 클릭
    $(".register-btn").on('click', function(){
    	$("#seq").val("");
    	$("#title").val("");
    	$("#select2 option:eq(0)").prop("selected", true);
    	Editor.modify({content:" ", attachments:[]});
    	$("#tx_attach_div").css("display","none");
    	$(".note-list-div").css("display","none");
		$(".note-view-div").css("display","none");
		$(".note-register-div").css("display","block");
		$(".register-mode").css("display","block");
		$(".update-mode").css("display","none");
    });
    
    //액션없이 메인버튼 눌렀을 때
    $('.main-back').on('click', function(){
    	$(".note-list-div").css("display","block");
		$(".note-view-div").css("display","none");
		$(".note-register-div").css("display","none");
    });
    
    //노트 수정화면 이동
    $(".note-update").on('click', function() {
    	$.ajax({
            url: '/note/selectNote',
            data: {
                "seq" : $("#seq").val()
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	$("#title").val(result.note.title);
            	$(".category-list").val(result.note.noteCategory.seq);
            	$("#contents_source").val(result.note.contents);
            	var attachments = {};
            	attachments['image'] = [];
            	
            	for(var i = 0; i < result.fileList.length; i++) {
            		attachments['image'].push({
                		'attacher': 'image',
                		'data': {
                			'imageurl': result.fileList[i].fileUrl,
                			'filename': result.fileList[i].fileName,
                			'filesize': result.fileList[i].fileSize,
                			'originalurl': result.fileList[i].filePath,
                			'thumburl': result.fileList[i].filePath
                		}
                	});
            	}
            	
            	/* attachments['file'] = [];
            	attachments['file'].push({
            		'attacher': 'file',
            		'data': {
            			'attachurl': 'http://cfile297.uf.daum.net/attach/207C8C1B4AA4F5DC01A644',
            			'filemime': 'image/gif',
            			'filename': 'editor_bi.gif',
            			'filesize': 640
            		}
            	}); */
            	/* 저장된 컨텐츠를 불러오기 위한 함수 호출 */
            	Editor.modify({
            		"attachments": function () { /* 저장된 첨부가 있을 경우 배열로 넘김, 위의 부분을 수정하고 아래 부분은 수정없이 사용 */
            			var allattachments = [];
            			for (var i in attachments) {
            				allattachments = allattachments.concat(attachments[i]);
            			}
            			return allattachments;
            		}(),
            		"content": document.getElementById("contents_source") /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
            	});
            	$(".note-list-div").css("display","none");
        		$(".note-view-div").css("display","none");
        		$(".note-register-div").css("display","block");
        		$(".register-mode").css("display","none");
        		$(".update-mode").css("display","block");
            }
    	});
    });
    
    $(".view-back").on('click', function(){
    	var seq = $("#seq").val();
    	noteView(seq);
    });
    
    $(".category-list").on('change', function(){
    	$("#category").val($(this).val());
    	init(0);
    });
</script>