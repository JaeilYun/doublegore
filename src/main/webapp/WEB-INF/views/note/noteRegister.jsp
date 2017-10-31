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
						<form name="tx_editor_form" id="tx_editor_form" action="/note/insertNote" method="post" accept-charset="utf-8">
							<div class="form-horizontal">
								<div class="form-group">
									<label class="col-md-1 control-label">Title</label>
									<div class="col-md-11">
										<input type="text" name="title" class="form-control" placeholder="Title">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-1 control-label">Category</label>
									<div class="col-md-11">
										<select name="select" id="select2" class="select2">
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
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="widget-footer" style="text-align: right;">
					<button type="button" class="btn btn-default note-back-btn" style="border-radius: 4px;"><i class="fa fa-arrow-left"></i> Back</button>
					<button type="button" class="btn btn-success" style="border-radius: 4px;" onClick="saveContent();"><i class="fa fa-floppy-o"></i> Save</button>
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
	
	var config = { 
		txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */ 
		txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */ 
		txService: 'sample', /* 수정필요없음. */ 
		txProject: 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */ 
		initializedId: "", /* 대부분의 경우에 빈문자열 */ 
		wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */ 
		form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */ 
		txIconPath: "${contextRoot}/assets/images/icon/editor/", /* 에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */ 
		txDecoPath: "${contextRoot}/assets/images/deco/contents/", /* 본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */ 
		canvas: { 
			exitEditor:{ 
				/* 
				desc:'빠져 나오시려면 shift+b를 누르세요.', 
				hotKey: { 
					shiftKey:true, 
					keyCode:66 
				}, 
				nextElement: document.getElementsByTagName('button')[0] */ 
			}, 
			styles: { 
				color: "#123456", /* 기본 글자색 */ 
				fontFamily: "굴림", /* 기본 글자체 */ 
				fontSize: "10pt", /* 기본 글자크기 */ 
				backgroundColor: "#fff", /*기본 배경색 */ 
				lineHeight: "1.5", /*기본 줄간격 */ 
				padding: "8px" /* 위지윅 영역의 여백 */ 
			}, 
			showGuideArea: false 
		}, 
		events: { 
			preventUnload: false 
		}, 
		sidebar: { 
			attachbox: { 
				show: true, 
				confirmForDeleteAll: true 
			},

			attacher:{ 
				image:{ 
					features:{left:250,top:65,width:400,height:190,scrollbars:0}, //팝업창 사이즈 
					popPageUrl:'/note/imagePopup' //팝업창 주소
				}
			},
			
			capacity: { 
				maximum: 5*1024*1024 // 최대 첨부 용량 (5MB)
			}
		}, 
		size: { 
			contentWidth: 700 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */ 
		}
	}; 
	
	EditorJSLoader.ready(function(Editor) { 
		var editor = new Editor(config); 
	});
});

function saveContent() {
	Editor.save(); // 이 함수를 호출하여 글을 등록하면 된다.
}

function validForm(editor) { 
	var validator = new Trex.Validator(); 
	var content = editor.getContent(); 
	if (!validator.exists(content)) { 
		alert('내용을 입력하세요'); 
		return false; 
	} 
	return true; 
}

function setForm(editor) { 
	var i, input; 
	var form = editor.getForm(); 
	var content = editor.getContent();
	
	// 본문 내용을 필드를 생성하여 값을 할당하는 부분
	var textarea = document.createElement('textarea');
	textarea.style.display = "none";
	textarea.name = 'content'; //name값 수정 
	textarea.value = content;
	form.createField(textarea); 
	
	/* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
   	 첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */
	/* var images = editor.getAttachments('image');
	for (i = 0; i < images.length; i++) {
	    // existStage는 현재 본문에 존재하는지 여부
	    if (images[i].existStage) {
	        // data는 팝업에서 execAttach 등을 통해 넘긴 데이터
	        alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
	        input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'attach_image';
	        input.value = images[i].data.imageurl;  // 예에서는 이미지경로만 받아서 사용
	        form.createField(input);
	    }
	}
	
	var files = editor.getAttachments('file');
	for (i = 0; i < files.length; i++) {
	    input = document.createElement('input');
	    input.type = 'hidden';
	    input.name = 'attach_file';
	    input.value = files[i].data.attachurl;
	    form.createField(input);
	} */
	
	return true; 
}
  
</script>