<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>

<link href="${contextRoot}/assets/css/popup.css" rel="stylesheet" type="text/css">
<script src="${contextRoot}/assets/js/popup.js"></script>
<script src="${contextRoot}/assets/js/jquery.form.min.js"></script>

<div class="wrapper">
	<div class="header">
		<h1>사진 첨부</h1>
	</div>	
	<div class="body">
		<dl class="alert">
	    	<dt>&nbsp;10MB이하 (JPG,GIF,PNG,BMP)</dt> 
	    	<dd> <form id="daumOpenEditorForm" encType="multipart/form-data" method="post" action=""> 
	    	
	    		<!-- 파일첨부 --> 
	    		<div class="file"> 
	    			<input disabled class="file-text"> 
	    			<label class="file-btn" for="uploadInputBox">사진첨부</label> 
	    			<input id="uploadInputBox" style="display: none;" type="file" name="Filedata"><!-- 버튼대체용(안보임) --> 
	    		</div> 
	    		<!-- //파일첨부 -->
	    	</form> 
	    	</dd>
		</dl>
	</div>
	<div class="footer">
		<ul>
			<li class="submit"><a href="#" title="등록" class="btnlink">등록</a> </li>
			<li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li>
		</ul>
	</div>
</div>

<script>
$(document).ready(function() {
	// <input type=file> 태그 기능 구현 
	$('.file input[type=file]').change(function (){
		var inputObj = $(this).prev().prev(); // 두번째 앞 형제(text) 객체
		var fileLocation = $(this).val(); // 파일경로 가져오기 
		
		inputObj.val(fileLocation.replace('C:\\fakepath\\','')); // 몇몇 브라우저는 보안을 이유로 경로가 변경되서 나오므로 대체 후 text에 경로 넣기 });
	});
	
	// 등록버튼 클릭 이벤트 
	$('.submit a').on('click', function () { 
		var form = $('#daumOpenEditorForm'); // form id값 
		var fileName = $('.file input[type=file]').val(); // 파일명(절대경로명 또는 단일명)
		form.ajaxSubmit({ 
			type: 'POST', 
			url: '/note/imageUpload', 
			dataType: 'JSON', // 리턴되는 데이타 타입 
			beforeSubmit: function() { 
				if(validation(fileName)) { // 확장자 체크 (jpg, gif, png, bmp) 
					return false; 
				} 
			}, success: function(fileInfo) { // fileInfo는 이미지 정보를 리턴하는 객체 
				if(fileInfo.result===-1) { // 서버단에서 체크 후 수행됨 
					alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.'); 
					return false; 
				} else if(fileInfo.result===-2) { // 서버단에서 체크 후 수행됨 
					alert('파일이 10MB를 초과하였습니다.'); 
					return false; 
				} else { 
					done(fileInfo); // 첨부한 이미지를 에디터에 적용시키고 팝업창을 종료 
				}
			}
		});
	});

	initUploader();
});

//첨부한 이미지를 에디터에 적용시키는 함수 
function done(fileInfo) { // fileInfo는 Ajax 요청 후 리턴하는 JSON형태의 데이터를 담을 객체
	if (typeof(execAttach) == 'undefined') { 
		return; 
	} 
	var _mockdata = { 
		'width': "100%",
		'imageurl': fileInfo.imageurl, 
		'filename': fileInfo.filename, 
		'filesize': fileInfo.filesize, 
		'imagealign': fileInfo.imagealign, 
		'originalurl': fileInfo.originalurl, 
		'thumburl': fileInfo.thumburl 
	};
	
	execAttach(_mockdata); // 다음오픈에디터에 붙이기 
	closeWindow(); // 이미지 팝업 종료 
}

//잘못된 경로로 접근할 때 호출되는 함수
function initUploader(){
	var _opener = PopupUtil.getOpener();
	if (!_opener) {
	alert('잘못된 경로로 접근하셨습니다.');
   		return;
	}

	var _attacher = getAttacher('image', _opener);
	registerAction(_attacher);
}

//확장자 체크 (서버단에서도 검사함) 
function validation(fileName) {
	var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1; // .뒤부터 확장자 
	var fileNameExtension = fileName.toLowerCase().substring(fileNameExtensionIndex,fileName.length); // 확장자 자르기 
	
	if(!((fileNameExtension === 'jpg') || 
			(fileNameExtension === 'gif') || 
			(fileNameExtension === 'png') || 
			(fileNameExtension === 'bmp'))) { 
		alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.'); 
		return true; 
	} else { 
		return false;
	}
}

</script>