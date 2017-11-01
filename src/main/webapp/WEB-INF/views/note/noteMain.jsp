<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="expanded-full col-lg-6">
	<div class="content">
		<div class="main-content note-list-div" style="display: block;">
			<div class="widget-content bottom-30px">
				<div class="row">
					<div class="col-md-9">
						<a href="#" class="btn btn-primary register-btn" style="border-radius: 4px;"><i class="fa fa-plus-square"></i> 글쓰기</a>
						<select id="multiselect4-filter" name="multiselect4[]" class="multiselect">
							<c:forEach var="list" items="${categoryList}">
								<option value="${list.seq}">${list.type}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-3">
						<a href="#" class="btn btn-primary pull-right setting-btn" style="border-radius: 4px;"><i class="fa fa-cog"></i> 설정</a>
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
							<h4 style="color: #398439; font-weight: 600;">카테고리</h4>
							<h1 style="font-weight: 600;padding-bottom: 10px;">제목입니다</h1>
							<span class="timestamp" style="color:#bbb">2017-11-01 00:45</span>
						</div>
					</div>
					<div style="border-bottom:1px solid #ddd"></div>
					<div style="padding-top: 40px;">
						<div class="widget-content">
							<p>
							00:35:33.620 [http-nio-8080-exec-18] DEBUG org.springframework.orm.jpa.JpaTransactionManager - Closing JPA EntityManager [SessionImpl(PersistenceContext[entityKeys=[EntityKey[com.home.contents.note.entity.NoteEntity#292], EntityKey[com.home.contents.note.entity.NoteEntity#291], EntityKey[com.home.contents.note.entity.NoteEntity#296], EntityKey[com.home.contents.note.entity.NoteEntity#295], EntityKey[com.home.contents.note.entity.NoteEntity#294], EntityKey[com.home.contents.note.entity.NoteCategoryEntity#1], EntityKey[com.home.contents.note.entity.NoteEntity#293], EntityKey[com.home.contents.note.entity.NoteEntity#300], EntityKey[com.home.contents.note.entity.NoteEntity#299], EntityKey[com.home.contents.note.entity.NoteEntity#298], EntityKey[com.home.contents.note.entity.NoteEntity#297]],collectionKeys=[CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#299], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#298], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#300], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#295], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#294], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#297], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#296], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#291], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#293], CollectionKey[com.home.contents.note.entity.NoteEntity.noteFiles#292], CollectionKey[com.home.contents.note.entity.NoteCategoryEntity.notes#1]]];ActionQueue[insertions=ExecutableList{size=0} updates=ExecutableList{size=0} deletions=ExecutableList{size=0} orphanRemovals=ExecutableList{size=0} collectionCreations=ExecutableList{size=0} collectionRemovals=ExecutableList{size=0} collectionUpdates=ExecutableList{size=0} collectionQueuedOps=ExecutableList{size=0} unresolvedInsertDependencies=null])] after transaction
00:35:33.620 [http-nio-8080-exec-18] DEBUG org.springframework.orm.jpa.EntityManagerFactoryUtils - Closing JPA EntityManager
00:35:33.621 [http-nio-8080-exec-18] DEBUG org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor - Written [Page 1 of 12 containing com.home.contents.note.entity.NoteEntity instances] as "application/json" using [org.springframework.http.converter.json.MappingJackson2HttpMessageConverter@78923b38]
00:35:33.621 [http-nio-8080-exec-18] DEBUG org.springframework.web.servlet.DispatcherServlet - Null ModelAndView returned to DispatcherServlet with name 'dispatcher': assuming HandlerAdapter completed request handling
00:35:33.621 [http-nio-8080-exec-18] DEBUG org.springframework.web.servlet.DispatcherServlet - Successfully completed request
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="widget-footer" style="text-align: right;">
						<button type="button" class="btn btn-default note-back-btn" style="border-radius: 4px;"><i class="fa fa-arrow-left"></i> Back</button>
						<button type="button" class="btn btn-success" style="border-radius: 4px;" onClick="saveContent();"><i class="fa fa-floppy-o"></i> Edit</button>
					</div>
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
				<h4 class="modal-title" id="myModalLabel">Settings</h4>
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
        		var noteStr = "";
        		var pagingStr = "";
        		$(".noteList").empty();
        		$(".pagination").empty();
        		$("#page").val(result.number);
        		
        		
        		for(var i = 0; i < result.content.length; i++){
        			noteStr += '<div style="padding: 8px;" onClick="noteView('+result.content[i].seq+')">';
        			noteStr += '<div class="widget-content" style="padding-bottom:15px;">';
        			noteStr += '<h3 style="font-weight: 500;">'+result.content[i].title+'</h3>';
        			noteStr += '<div style="font-size:15px;">'+result.content[i].contents+'</div>';
        			noteStr += '<div>';
        			noteStr += '<span style="color: #1D92AF;font-weight: 600;">'+result.content[i].noteCategory.type+'</span><span class="timestamp pull-right" style="color: #bbb;">'+result.content[i].updatedDate+'</span>';
        			noteStr += '</div></div></div><div style="border-bottom:1px solid #ddd"></div>';
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
		$(".note-list-div").css("display","none");
		$(".note-view-div").css("display","block");
	}

</script>