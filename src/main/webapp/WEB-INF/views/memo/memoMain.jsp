<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="col-lg-6">
	<div class="content">
		<div class="main-content" style="padding: 20px 3px 10px 3px;">
			<!-- WIDGET QUICK NOTE -->
			<div class="widget widget-quick-note quick-note-create">
				<div class="widget-content">
					<form id="memoForm" class="form-horizontal" role="form">
						<textarea class="form-control noteContent" id="memo-contents" rows="1" cols="30" placeholder="메모하세요."></textarea>
					</form>
				</div>
				<div class="widget-footer">
					<div class="btn-group">
						<button type="button" class=" btn btn-clean note-view-menu-btn" style="color: #bbb;">사진</button>
					</div>
					<div class="btn-group" style="float: right;">
						<button type="button" class="btn btn-clean note-view-delete-btn" style="color: rgba(219, 56, 51, 0.5);" onClick="reset();">초기화</button>
						<button type="button" class="btn btn-clean note-view-edit-btn" style="color: rgba(75, 168, 75, 0.5);" onClick="save();" disabled="true">저장</button>
					</div>
				</div>
			</div>
			<!-- END WIDGET QUICK NOTE -->
			<div class="project-section activity">
				<h3></h3>
				<ul class="list-unstyled activity-list">
    	            <li style="padding: 10px;">
    	            	<div>
    	            		<p data-toggle="collapse" href="#bbb" style="text-overflow: ellipsis;padding-right: 30px;overflow: hidden;white-space: nowrap;font-weight:600;">fsdfsdfdsfdsfsd</p>
    	            		<div id="bbb" class="panel-collapse collapse">
    	            			<div style="padding: 5px 25px 5px 5px;">sdvdsvsdvsd</div>
    	            		</div>
    	            		<span class="close" onClick="memoDelete(s)" style="margin-top: -32px;margin-right: 7px;">&times;</span>
    	            		<span class="timestamp" style="text-align: right; margin-right: 10px;">2017-11-11 44:42</span>
    	            	</div>
    	            </li>
					<li style="padding: 15px 0px 30px 0px;">
						<div>
	    	            	<div class="col-md-9" data-toggle="collapse" href="#aaa" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;font-weight:600;">
	   	            			fsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsdfsdfsdfdsfdsfsd
	   	            		</div>
	   	            		<div class="col-md-3" style="text-align: right;margin-top: 2px;">
	   	            			<span class="close" onClick="memoDelete(s)" style="margin: -5px 0px 10px 15px;">&times;</span>
	   	            			<span class="timestamp">2017-11-11 44:42</span>
	   	            		</div>
	   	            		<div id="aaa" class="panel-collapse collapse">
	   	            			<div style="padding: 5px 30px 0px 25px;word-break: break-all;">sdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsd</div>
	   	            		</div>
	   	            	</div>
    	            </li>
    	            <li style="padding: 10px;">
    	            	<div><p data-toggle="collapse" href="#ccc" style="text-overflow: ellipsis;padding-right: 30px;overflow: hidden;white-space: nowrap;font-weight:600;">fsdfsdfdsfdsfsd</p>
    	            		<div id="ccc" class="panel-collapse collapse">
    	            			<div style="padding: 5px 25px 5px 5px;">sdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsdsdvdsvsdvsd</div>
    	            		</div>
    	            		<span class="close" onClick="memoDelete(s)" style="margin-top: -32px;margin-right: 7px;">&times;</span>
    	            		<span class="timestamp" style="text-align: right; margin-right: 10px;">2017-11-11 44:42</span>
    	            	</div>
    	            </li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END CONTENT WRAPPER -->
<div class="col-lg-3"></div>
<input type="hidden" id="page" name="page" value="0">
<input type="hidden" id="size" name="size" value="15">

<script>
    $(document).ready(function(){
    	//init();
    	
    	$(window).scroll(function() {
    	    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    	      $("#page").val(Number($("#page").val())+1);
    	      $.ajax({
    	            url: '/memo/selectMemo',
    	            data: {
    	                "page" : $("#page").val(),
    	                "size" : $("#size").val(),
    	            },
    	            type: 'POST',
    	            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    	            success: function (result) {
    	            	var str = "";
    	            	for(var i = 0; i < result.content.length ; i++) {
    	            		str += '<li style="padding: 10px;">';
    	            		str += '<div><p data-toggle="collapse" href="#'+result.content[i].seq+'" style="text-overflow: ellipsis;padding-right: 30px;overflow: hidden;white-space: nowrap;font-weight:600;">'+result.content[i].contents.split('<br>')[0]+' </p>';
    	            		str += '<div id="'+result.content[i].seq+'" class="panel-collapse collapse">';
    	            		str += '<div style="padding: 5px 25px 5px 5px;">'+result.content[i].contents+' </div>';
    	            		str += '</div><span class="close" onClick="memoDelete('+result.content[i].seq+')" style="margin-top: -32px;margin-right: 7px;">&times;</span><span class="timestamp" style="text-align: right; margin-right: 10px;">'+result.content[i].createdDate+'</span></div></li>';
    	            	}
    	            	$(".activity-list").append(str);
    	            }
    	    	});
    	      
    	    }
    	});
    	
    	$("#memo-contents").on("keyup", function() {
    		if($('#memo-contents').val().length > 0) {
    			$(".note-view-edit-btn").removeAttr("disabled");
    		} else {
    			$(".note-view-edit-btn").attr("disabled","disabled");
    		}
    	});
    	
    	reset = function(){
    		$("#memo-contents").val("");
    	}
    	
    	save = function(){
    		$.ajax({
                url: '/memo/insertMemo',
                data: {
                    "contents" : $("#memo-contents").val().replace(/\n/g, "<br>")
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                	reset();
                	$('.quick-note-create').find('textarea').attr('rows', 1);
    				$('.quick-note-create').find('.widget-footer').hide();
    				var str = "";
               		str += '<li style="padding: 10px;">';
               		str += '<div><p data-toggle="collapse" href="#'+result.seq+'" style="text-overflow: ellipsis;padding-right: 30px;overflow: hidden;white-space: nowrap;font-weight:600;">'+result.contents.split('<br>')[0]+' </p>';
               		str += '<div id="'+result.seq+'" class="panel-collapse collapse">';
               		str += '<div style="padding: 5px 25px 5px 5px;">'+result.contents+' </div>';
               		str += '</div><span class="close" onClick="memoDelete('+result.seq+')" style="margin-top: -32px;margin-right: 7px;">&times;</span><span class="timestamp" style="text-align: right; margin-right: 10px;">'+result.createdDate+'</span></div></li>';
                	$(".activity-list").prepend(str);
                }
    		});
    	}
    });
    
    init = function(){
    	$.ajax({
            url: '/memo/selectMemo',
            data: {
                "page" : $("#page").val(),
                "size" : $("#size").val(),
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	$(".activity-list").empty();
            	var str = "";
            	for(var i = 0; i < result.content.length ; i++) {
            		str += '<li style="padding: 10px;">';
            		str += '<div><p data-toggle="collapse" href="#'+result.content[i].seq+'" style="text-overflow: ellipsis;padding-right: 30px;overflow: hidden;white-space: nowrap;font-weight:600;">'+result.content[i].contents.split('<br>')[0]+' </p>';
            		str += '<div id="'+result.content[i].seq+'" class="panel-collapse collapse">';
            		str += '<div style="padding: 5px 25px 5px 5px;">'+result.content[i].contents+' </div>';
            		str += '</div><span class="close" onClick="memoDelete('+result.content[i].seq+')" style="margin-top: -32px;margin-right: 7px;">&times;</span><span class="timestamp" style="text-align: right; margin-right: 10px;">'+result.content[i].createdDate+'</span></div></li>';
            	}
            	$(".activity-list").append(str);
            }
    	});
    }
    
	memoDelete = function(seq){
		$.ajax({
            url: '/memo/deleteMemo',
            data: {
                "seq" : seq
            },
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (result) {
            	document.getElementById(seq).closest("li").remove();
            }
		});
	};
</script>