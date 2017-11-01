<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="expanded-full col-lg-6">
	<div class="content">
		<div class="main-content">
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
			<div class="noteList">
				<c:forEach var="list" items="${noteList.content}">
					<div class="widget" style="border-radius: 4px;">
						<div class="widget-content" style="margin: -10px 40px 8px 40px;">
							<h3 style="font-weight: 700;">${list.title }</h3>
							<%-- <div style="font-size: 18px;margin-bottom: 15px;">
								${list.contents }
							</div> --%>
							<div>
								<span style="color: #1D92AF;font-weight: 600;">${list.noteCategory.type }</span><span class="timestamp pull-right" style="color: #bbb;">${list.updatedDate }</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div style="text-align: center;">
				<ul class="pagination" style="font-size: 20px;">
					<c:choose>
						<c:when test="${noteList.hasPrevious() eq 'true'}">
							<li><a href="#" class="pagingClick" onClick="pagingClick();"><i class="fa fa-chevron-left"></i></a></li>
						</c:when>
						<c:otherwise>
							<li class="disabled"><a href="#" class="pagingClick" onClick="pagingClick();"><i class="fa fa-chevron-left"></i></a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="list" items="${noteList.getContent()}" begin="0" end="${end}" varStatus="idx">
						<c:choose>
							<c:when test="${noteList.getNumber()+1 eq idx.count}">  
								<li class="active"><a href="#" class="pagingClick">${idx.count}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#" class="pagingClick" onClick="pagingClick(${idx.count-1});">${idx.count}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${noteList.hasNext() eq 'true'}">
							<li><a href="#" class="pagingClick"  onClick="pagingClick(${noteList.getNumber()+5});"><i class="fa fa-chevron-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li class="disabled"><a href="#" class="pagingClick"><i class="fa fa-chevron-right"></i></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
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
			<div class="modal-body">
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
	 			str +=         '<button id="btn1" class="btn btn-danger" type="button"><i class="fa fa-minus" aria-hidden="true"></i></button>';
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
             			str += 	   '<input autocomplete="off" class="input form-control" id="'+result[i].seq+'" type="text" value="'+result[i].type+'">';
             			str +=     '<span class="input-group-btn">';
             			str +=         '<button class="btn btn-danger" id="zzzzz" type="button" onClick="removeCategory(this);"><i class="fa fa-minus" aria-hidden="true"></i></button>';
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
    });

	function removeCategory(val){
		$(val).parents(".input-group-appendable").remove();
	}
	
	$(".pagingClick").on('click', function(e) {
		if($(this).closest("li").hasClass("active")) {
			e.preventDefault();
		}
	});
	
	pagingClick = function(page) {
		$.ajax({
            url: '/note/search',
            data: {
                "page" : page,
                "size" : $("#size").val()
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
        			noteStr += '<div class="widget" style="border-radius: 4px;">';
        			noteStr += '<div class="widget-content" style="margin: -10px 40px 8px 40px;">';
        			noteStr += '<h3 style="font-weight: 700;">'+result.content[i].title+'</h3>';
        			noteStr += '<div>';
        			noteStr += '<span style="color: #1D92AF;font-weight: 600;">'+result.content[i].noteCategory.type+'</span><span class="timestamp pull-right" style="color: #bbb;">'+result.content[i].updatedDate+'</span>';
        			noteStr += '</div></div></div>';
        		}
        		$(".noteList").append(noteStr);
        		
        		var startPage = (result.number < 5) ? 1 : result.number-3;
        		var endPage = (result.totalPages < result.number+6) ? result.totalPages : result.number+5;
        		var prePage = (result.number < 5) ? 0 : result.number-5;
        		var postPage = (result.totalPages < result.number+6) ? result.totalPages-1 : result.number+5

    			if(result.first == true) {
    				pagingStr += '<li class="disabled"><a href="#" class="pagingClick"><i class="fa fa-chevron-left"></i></a></li>';
    			} else {
    				pagingStr += '<li><a href="#" class="pagingClick" onClick="pagingClick('+prePage+');"><i class="fa fa-chevron-left"></i></a></li>';
    			}
        		for(var i = startPage; i < endPage+1; i++) {
        			if(i == result.number+1) {
        				pagingStr += '<li class="active"><a href="#" class="pagingClick"">'+(i)+'</a></li>';
        			} else {
        				pagingStr += '<li><a href="#" class="pagingClick" onClick="pagingClick('+(i-1)+');">'+(i)+'</a></li>';
        			}
        		}
        		if(result.last == true) {
    				pagingStr += '<li class="disabled"><a href="#" class="pagingClick""><i class="fa fa-chevron-right"></i></a></li>';
    			} else {
    				pagingStr += '<li><a href="#" class="pagingClick" onClick="pagingClick('+postPage+');"><i class="fa fa-chevron-right"></i></a></li>';
    			}
        		$(".pagination").append(pagingStr);
            }
        });
	}

</script>