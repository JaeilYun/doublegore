<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="expanded-full col-lg-6">
	<div class="content">
		<div class="main-content note-list-div" style="display: block;padding-top: 20px;">
			<div class="widget-content bottom-30px">
				<div class="row">
					<div class="col-md-2" style="text-align: left;">
						<div class="form-control" style="border: none;">
							<span style="padding: 3px;font-size: 20px;" class="register-btn">
								<a href="#" class="note-view-top-btn" style="text-decoration:none !important;color: #bbb;">글쓰기</a>
							</span>
						</div>
					</div>
					<div class="col-md-8">
						<select class="form-control">
							<c:forEach var="list" items="${categoryList}">
								<option value="${list.seq}">${list.type}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2" style="text-align: right;">
						<div class="form-control" style="border: none;">
							<span style="padding: 3px;font-size: 20px;" class="setting-btn">
								<a href="#" class="note-view-top-btn" style="text-decoration:none !important;color: #bbb;">설정</a>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="noteList"></div>
			<div style="text-align: center;padding-top: 30px;">
				<ul class="pagination" style="font-size: 20px;"></ul>
			</div>
		</div>
		<div class="main-content note-view-div" style="display: none;">
			<div class="row">
				<div class="col-md-12">
					<!-- BASIC INPUT -->
					<div style="padding-top: 30px;padding-bottom: 40px;">
						<div class="widget-content" style="text-align: center;">
							<div style="text-align: right;height: 50px;">
								<input type="hidden" class="note-view-seq" value="">
								<span style="padding: 3px;font-size: 20px;" class="note-view-back-btn">
									<a href="#" class="note-view-btnset" style="text-decoration:none !important;color: #bbb;">메뉴</a>
								</span>
								<span style="padding: 3px;color: #bbb;font-size: 20px;" class="">
									<a href="#" class="note-view-btnset" style="text-decoration:none !important;color: #bbb;">수정</a>
								</span>
								<span style="padding: 3px;color: #bbb;font-size: 20px;" class="note-view-delete-btn">
									<a href="#" class="note-view-btnset" style="text-decoration:none !important;color: #bbb;">삭제</a>
								</span>
							</div>
							<h4 style="color: #398439; font-weight: 600;" class="note-view-category"></h4>
							<h1 style="font-weight: 600;padding-bottom: 10px;" class="note-view-title"></h1>
							<span class="timestamp note-view-date" style="color:#bbb"></span>
						</div>
					</div>
					<div style="border-bottom:1px solid #ddd"></div>
					<div style="padding-top: 40px;padding-bottom: 40px;">
						<div class="widget-content">
							<div class="note-view-contents" style="line-height: 2;"></div>
						</div>
					</div>
					<div style="border-bottom:1px solid #ddd"></div>
				</div>
			</div>
		</div>
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
				<button type="button" class="btn btn-success" onClick="settingsRefresh();"><i class="fa fa-refresh"></i> Refresh</button>
				<button type="button" class="btn btn-custom-primary" onClick="settingsSave();"><i class="fa fa-check-circle"></i> Save changes</button>
				<button type="button" class="btn btn-default setting-modal" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
			</div>
		</div>
	</div>
</div>

<form id="registerForm" name="registerForm" method="post" action="/note/register">
</form>

<form id="mainForm" name="mainForm" method="post" action="/note/main">
	<input type="hidden" id="page" name="page" value="${noteList.getNumber()}">
	<input type="hidden" id="size" name="size" value="${noteList.getSize()}">
</form>

<script>
    $(document).ready(function(){
    	pagingClick();
    	$(".setting-btn").on('click', function(e) {
    		e.preventDefault();
    		settingsRefresh();
    		$(".setting-modal-btn").click();
    	});
    	
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
    	
    	categorySettings = function() {
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
            		$("#mainForm").submit();
                }
            });
    	}
    	
    	settingsRefresh = function() {
    		categorySettings();
    	}
    	
    	$(".register-btn").on('click', function(e) {
    		e.preventDefault();
    		$("#registerForm").submit();
    	});
    	

    	
    	$(".category-modal-body").on('click',function(){
    		$(".category-error-message").remove();
    		$(".input-group-appendable").removeClass("has-error");
    	});
    });

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
	
	pagingClick = function(page) {
		$.ajax({
            url: '/note/search',
            data: {
                "page" : (typeof page == 'undefined') ? "0" : page,
                "size" : "10"
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	if(result.content.length == 0) {
            		pagingClick((result.number-1) < 0 ? 0 : (result.number-1));
            	}
        		var noteStr = "";
        		var pagingStr = "";
        		$(".noteList").empty();
        		$(".pagination").empty();
        		$("#page").val(result.number);
        		
        		noteStr += '<div style="border-bottom:1px solid #ddd"></div>';
        		for(var i = 0; i < result.content.length; i++){
        			noteStr += '<a href="#" onClick="noteView('+result.content[i].seq+')" style="text-decoration:none !important;"><div class="note-list-hover" style="padding: 8px;border-right: 1px solid white; border-left: 1px solid white;">';
        			noteStr += '<div class="widget-content" style="padding-bottom:15px;">';
        			noteStr += '<h3 style="font-weight: 500;color:#555 !important;padding-bottom: 10px;">'+result.content[i].title+'</h3>';
        			noteStr += '<div style="color:#555 !important;">'+result.content[i].contents+'</div>';
        			noteStr += '<div>';
        			noteStr += '<span style="color: #1D92AF !important;font-weight: 500;">'+result.content[i].noteCategory.type+'</span><span class="timestamp pull-right" style="color: #bbb;">'+result.content[i].updatedDate+'</span>';
        			noteStr += '</div></div></div></a><div style="border-bottom:1px solid #ddd"></div>';
        		}
        		$(".noteList").append(noteStr);
        		
        		var startPage = (result.number < 5) ? 1 : result.number-3;
        		var endPage = (result.totalPages < result.number+6) ? result.totalPages : result.number+5;
        		var prePage = (result.number < 5) ? 0 : result.number-5;
        		var postPage = (result.totalPages < result.number+6) ? result.totalPages-1 : result.number+5

    			if(result.first == true) {
    				pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-left"></i></a></li>';
    			} else {
    				pagingStr += '<li><a href="#" onClick="pagingClick('+prePage+');"><i class="fa fa-chevron-left"></i></a></li>';
    			}
        		for(var i = startPage; i < endPage+1; i++) {
        			if(i == result.number+1) {
        				pagingStr += '<li class="active"><a href="#" onClick="return false">'+(i)+'</a></li>';
        			} else {
        				pagingStr += '<li><a href="#" onClick="pagingClick('+(i-1)+');">'+(i)+'</a></li>';
        			}
        		}
        		if(result.last == true) {
    				pagingStr += '<li class="disabled"><a href="#" onClick="return false"><i class="fa fa-chevron-right"></i></a></li>';
    			} else {
    				pagingStr += '<li><a href="#" onClick="pagingClick('+postPage+');"><i class="fa fa-chevron-right"></i></a></li>';
    			}
        		$(".pagination").append(pagingStr);
            }
        });
	}
	
	noteView = function(seq){
		$.ajax({
            url: '/note/selectNote',
            data: {
                "seq" : seq
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	$(".note-view-seq").val(result.seq);
            	$(".note-view-category").text(result.noteCategory.type);
            	$(".note-view-title").text(result.title);
            	$(".note-view-date").text(result.updatedDate);
            	$(".note-view-contents").html(result.contents);
        		$(".note-list-div").css("display","none");
        		$(".note-view-div").css("display","block");
            }
		});
	}
	
	$(".note-view-back-btn").on('click', function(){
		$(".note-list-div").css("display","block");
		$(".note-view-div").css("display","none");
	});
	
	$(".note-view-delete-btn").on('click', function(){
		$.ajax({
            url: '/note/deleteNote',
            data: {
                "seq" : $(".note-view-seq").val(),
                "page" : $("#page").val()
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	pagingClick(result);
            	$(".note-view-back-btn").click();
            }
		});
	});

</script>