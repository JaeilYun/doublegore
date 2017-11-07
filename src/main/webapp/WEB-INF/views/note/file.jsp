<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link href="${contextRoot}/assets/css/popup.css" rel="stylesheet" type="text/css">
<script src="${contextRoot}/assets/js/popup.js"></script>
<script src="${contextRoot}/assets/js/jquery.form.min.js"></script>

<div class="wrapper">
	<div class="header">
		<h1>파일 첨부</h1>
	</div>	
	<div class="body">
		<dl class="alert"> 
			<dt>&nbsp;20MB이하만 가능합니다.</dt> 
			<dd> 
				<form id=daumOpenEditorForm encType=multipart/form-data method=post action=""> 
					<!-- 파일첨부 --> 
					<div class=file> 
						<input disabled class=file-text> 
						<label class=file-btn for=uploadInputBox>파일첨부</label> 
						<input id=uploadInputBox style="display: none" type=file name=Filedata><!-- 버튼대체용(안보임) --> 
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
$(document).ready(function (){ 
	// <input type=file> 태그 기능 구현
	$('.file input[type=file]').change(function (){ 
		var inputObj = $(this).prev().prev(); // 두번째 앞 형제(text) 객체
		var fileLocation = $(this).val(); // 파일경로 가져오기 
		
		inputObj.val(fileLocation.replace('C:\\fakepath\\','')); // 몇몇 브라우저는 보안을 이유로 경로가 변경되서 나오므로 대체 후 text에 경로 넣기 
	}); 
	
	// 등록버튼 클릭 이벤트 
	$('.submit a').on('click', function () { 
		var page = '${param.page}'; // 어디페이지에서 보냈는지 체크 
		var form = $('#daumOpenEditorForm');
		
		form.ajaxSubmit({ 
			type: 'POST', 
			url: '/note/fileUpload', 
			dataType: 'JSON', // 리턴되는 데이타 타입 
			beforeSubmit: function() {}, 
			success: function(fileInfo) { // fileInfo는 이미지 정보를 리턴하는 객체 
				if(fileInfo.result==-2) { 
					alert('파일이 20MB를 초과하였습니다.'); 
					return false; 
				} else {
					console.log(fileInfo);
					done(fileInfo); 
				}
			}
		});
	});
	
	initUploader();
});



//첨부한 파일을 에디터에 적용시키는 함수
function done(fileInfo) {
	if (typeof(execAttach) == 'undefined') {
      	return;
   	}
	
	var _mockdata = { 
		'attachurl': fileInfo.attachurl, 
		'filemime': fileInfo.filemime, 
		'filename': fileInfo.filename, 
		'filesize': fileInfo.filesize 
	};
	
	execAttach(_mockdata);
	closeWindow();
}

//잘못된 경로로 접근할 때 호출되는 함수
function initUploader(){
   	var _opener = PopupUtil.getOpener();
   	if (!_opener) {
        alert('잘못된 경로로 접근하셨습니다.');
       	return;
   	}
   	
   	var _attacher = getAttacher('file', _opener);
   	registerAction(_attacher);
}

</script>