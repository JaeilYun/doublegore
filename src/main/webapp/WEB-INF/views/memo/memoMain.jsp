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
				<div class="list-unstyled activity-list"></div>
    	            
				<!-- 샘플 디자인 -->
				<!-- <div style="border-bottom: 1px solid #ddd">
					<div class="panel-heading" style="padding-right: 140px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">
						<span class="panel-title" style="text-align: left;">
							<span data-toggle="collapse" data-parent="#accordion2" href="#collapseOne2" style="font-weight: 600;font-size: 14px;"> Collapsible Group Item #1Collapsible Group Item #1Collapsible Group Item #1Collapsible Group Item #1Collapsible Group Item #1Collapsible Group Item #1</span>
						</span>
					</div>
					<span style="float: right;margin-top: -33px; margin: -33px 10px 0 0;">
						<span class="close" onClick="memoDelete(s)">&times;</span>
    	            	<span class="timestamp" style="display: block;margin-top: 5px;font-size: 0.85em;color: #b1b1b1;width: 115px;">2017-11-11 44:42</span>
   	            	</span>
					<div id="collapseOne2" class="panel-collapse collapse">
						<div class="panel-body" style="padding:5px 15px 15px 20px;">Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo.</div>
					</div>
				</div> -->
			</div>
		</div>
	</div>
</div>
<!-- END CONTENT WRAPPER -->
<div class="col-lg-3"></div>
<input type="hidden" id="page" name="page" value="0">
<input type="hidden" id="size" name="size" value="30">

<script>
    $(document).ready(function(){
    	init();
    	
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
    	            		str += '<div class="parentDiv" style="border-bottom: 1px solid #ddd">'
	    					str +=		'<div data-toggle="collapse" href="#'+result.content[i].seq+'" class="panel-heading" style="padding-right: 140px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">';
	    					str +=			'<span class="panel-title" style="text-align: left;">';
	    					str += 				'<span style="font-weight: 600;font-size: 14px;">'+result.content[i].contents.split('<br>')[0]+'</span>';
	    					str += 			'</span>';
	    					str +=		'</div>';
	    					str +=		'<span style="float: right;margin-top: -33px; margin: -33px 10px 0 0;">';
	    					str +=			'<span class="close" onClick="memoDelete('+result.content[i].seq+')">&times;</span>';
	    					str +=			'<span class="timestamp" style="display: block;margin-top: 5px;font-size: 0.85em;color: #b1b1b1;width: 115px;">'+result.content[i].createdDate+'</span>';
	    					str +=		'</span>';
	    					str +=		'<div id="'+result.content[i].seq+'" class="panel-collapse collapse">';
	    					str +=			'<div class="panel-body" style="padding:5px 15px 15px 20px;">'+result.content[i].contents+' </div>';
	    					str +=		'</div>';
	    					str += '</div>';
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
               		str += '<div class="parentDiv" style="border-bottom: 1px solid #ddd">'
   					str +=		'<div data-toggle="collapse" href="#'+result.seq+'" class="panel-heading" style="padding-right: 140px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">';
   					str +=			'<span class="panel-title" style="text-align: left;">';
   					str += 				'<span style="font-weight: 600;font-size: 14px;">'+result.contents.split('<br>')[0]+'</span>';
   					str += 			'</span>';
   					str +=		'</div>';
   					str +=		'<span style="float: right;margin-top: -33px; margin: -33px 10px 0 0;">';
   					str +=			'<span class="close" onClick="memoDelete('+result.seq+')">&times;</span>';
   					str +=			'<span class="timestamp" style="display: block;margin-top: 5px;font-size: 0.85em;color: #b1b1b1;width: 115px;">'+result.createdDate+'</span>';
   					str +=		'</span>';
   					str +=		'<div id="'+result.seq+'" class="panel-collapse collapse">';
   					str +=			'<div class="panel-body" style="padding:5px 15px 15px 20px;">'+result.contents+' </div>';
   					str +=		'</div>';
   					str += '</div>';
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
            		str += '<div class="parentDiv" style="border-bottom: 1px solid #ddd">'
   					str +=		'<div data-toggle="collapse" href="#'+result.content[i].seq+'" class="panel-heading" style="padding-right: 140px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">';
   					str +=			'<span class="panel-title" style="text-align: left;">';
   					str += 				'<span style="font-weight: 600;font-size: 14px;">'+result.content[i].contents.split('<br>')[0]+'</span>';
   					str += 			'</span>';
   					str +=		'</div>';
   					str +=		'<span style="float: right;margin-top: -33px; margin: -33px 10px 0 0;">';
   					str +=			'<span class="close" onClick="memoDelete('+result.content[i].seq+')">&times;</span>';
   					str +=			'<span class="timestamp" style="display: block;margin-top: 5px;font-size: 0.85em;color: #b1b1b1;width: 115px;">'+result.content[i].createdDate+'</span>';
   					str +=		'</span>';
   					str +=		'<div id="'+result.content[i].seq+'" class="panel-collapse collapse">';
   					str +=			'<div class="panel-body" style="padding:5px 15px 15px 20px;">'+result.content[i].contents+' </div>';
   					str +=		'</div>';
   					str += '</div>';
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
            	document.getElementById(seq).closest(".parentDiv").remove();
            }
		});
	};
</script>