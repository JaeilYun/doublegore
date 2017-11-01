<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<div class="row">
	<div class="col-lg-3">
		<div class="content col-lg-8 pull-right">
				<div class="well" style="background-color: #f9f9f9;border: 1px solid lightgray;">
					<div class="top-content" style="margin-bottom: 0px;">
						<ul class="list-inline mini-stat">
							<li class="pull-left">
								<h5 style="text-align: right;">Counts <span class="stat-value stat-color-orange nodeFileCount"> 0</span></h5>
							</li>
							<li class="pull-left">
								<h5 style="text-align: right;">Size <span class="stat-value stat-color-blue nodeFileSize"> 0MB</span></h5>
							</li>
						</ul>
					</div>
				</div>
			
				<div class="well" style="margin-top: -7px;background-color: #f9f9f9;border: 1px solid lightgray;">
					<div id="tree-file-manager" class="king-tree" style="overflow: hidden;"></div>
				</div>
				<div class="well prev-image" style="margin-top: -7px; padding: 7px; display: none;background-color: #f9f9f9;border: 1px solid lightgray;"">
					<img class="prev-image-view" src="" style="width: 100%">
				</div>
		</div>
	</div>
	<div id="main-content-wrapper" class="expanded-full col-lg-6">
		<div class="content">
			<div class="main-content">
				<!-- FILE MANAGER -->
				<div class="file-manager">
					<div class="row" style="height: 95px;">
						<div class="col-md-10" style="padding: 30px 0px 20px 4px;">
							<button type="button" class="btn btn-default file-list-image-toggle file-top-menu-upload fileManage-top-button" disabled="disabled">
								<i class="fa fa-upload"> Upload</i>
							</button>
							<button type="button" class="btn btn-default file-list-image-toggle file-top-menu menu-download fileManage-top-button" disabled="disabled">
								<i class="fa fa-download"> Download</i>
							</button>
							<button type="button" class="btn btn-default file-list-image-toggle file-top-menu menu-delete fileManage-top-button" disabled="disabled"
									data-toggle="modal" data-target="#deleteModal">
								<i class="fa fa-close"> Delete</i>
							</button>
							<button type="button" class="btn btn-default file-list-image-toggle file-top-menu-select select fileManage-top-button" disabled="disabled">
								<i class="fa fa-square-o selectIcon"> Select</i>
							</button>
						</div>
						<div class="col-md-2 pull-right" style="padding: 30px 0px 20px 0px;text-align: right;">
							<button type="button" class="btn btn-default list-view-button"
									style="margin: -3px 0px -3px -3px; border-top-left-radius: 4px; border-bottom-left-radius: 4px; color: #fff; background-color: #626262; border-color: #555555;">
								<i class="fa fa-list"></i>
							</button>
							<button type="button" class="btn btn-default image-view-button"
									style="margin: -3px 7px -3px -3px; border-top-right-radius: 4px; border-bottom-right-radius: 4px; color: #333; background-color: #e6e6e6; border-color: #adadad;">
								<i class="fa fa-th"></i>
							</button>
						</div>
					</div>
					<div class="row">
						<div class="file-list-view" style="margin-top: -20px; display: block">
							<table id="datatable-file-manager" class="table table-sorting table-dark-header">
								<thead>
								<tr>
									<th class="col-lg-6">Name</th>
									<th class="col-lg-3">Last Modified</th>
									<th class="col-lg-2">Type</th>
									<th class="col-lg-1">Size</th>
								</tr>
								</thead>
								<tbody></tbody>
							</table>
							<div id="contextMenuFileManager">
								<ul class="dropdown-menu context-menu" role="menu">
									<li><a tabindex="-1" href="#"><i class="fa fa-download"></i> Download</a></li>
									<li><a tabindex="-1" href="#"><i class="fa fa-remove"></i> Delete</a></li>
									<li><a tabindex="-1" href="#"><i class="fa fa-eye"></i> View</a></li>
								</ul>
							</div>
						</div>
						<div class="file-image-view" style="display: none;">
							<div class="well demo-gallery" style="margin-top: -7px;background-color:#fff; border: none;padding: 14px;">
								<ul id="lightgallery" class="list-unstyled row" style="margin-top: -15px;margin-bottom: -15px;">
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- END FILE MANAGER -->
			</div>
		</div>
	</div>
	<!-- END CONTENT WRAPPER -->
	<div class="col-lg-3"></div>
</div>

<input id="fileuploadButton" style="display: none;" type="file" name="file" multiple >
<button id="uploadModalButton" style="display: none;" data-toggle="modal" data-target="#uploadModal"></button>
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">File Upload (<span class="completeCnt">0</span> / <span class="totalCnt">0</span>)</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<!-- PROJECT TABLE -->
					<table class="table colored-header project-list">
						<thead>
						<tr>
							<th>Name</th>
							<th>Size</th>
							<th style="width: 300px;">Status</th>
							<th style="width: 10px;"></th>
						</tr>
						</thead>
						<tbody class="fileUploadBody">
						</tbody>
					</table>
					<!-- END PROJECT TABLE -->
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success uploadStart"><i class="fa fa-floppy-o uploadStart-icon"></i> <span class="uploadButtonLabel">전송</span></button>
				<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myDeleteModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myDeleteModalLabel">정말로 삭제하시겠습니까?</h4>
			</div>
			<div style="padding: 15px; text-align: right;">
				<button type="button" class="btn btn-danger delete-confirm-btn"><i class="fa fa-trash"></i> 삭제</button>
				<button type="button" class="btn btn-default delete-modal-btn" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
			</div>
		</div>
	</div>
</div>

<form id="downloadForm" name="downloadForm" method="post" action="/file/downloadFile">
	<input type="hidden" id="fileName" name="fileName">
	<input type="hidden" id="nodeId" name="nodeId">
</form>

<script src="${contextRoot}/assets/js/plugins/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>

<script>
    var fileTable;
    var jstree;
    $(document).ready(function(){
        var uploaderArray = new Array();
        var selectedNode = "";
        var fileListImageStatus = true;
        $("#lightgallery").lightGallery();
        $("#fileuploadButton").on("change", function(){
            uploaderArray = new Array();
            $(".fileUploadBody").empty();
            var uploadFiles = document.getElementById('fileuploadButton');
            $("#uploadModalButton").click();
            for (var i = 0; i < uploadFiles.files.length; i++) {
                var file = uploadFiles.files[i];
                // 비동기 파일 업로드를 시작한다.
				var uploader = new Uploader(file);
				uploaderArray.push(uploader);
            }
			$(".totalCnt").text(uploadFiles.files.length);
		});

        $("#uploadModal").blur(function(){
            $("#fileuploadButton").val("");
		});

        $(".uploadStart").on("click", function(){
            $(".uploadStart").prop("disabled",true);
            $(".uploadStart-icon").removeClass("fa-floppy-o");
            $(".uploadStart-icon").addClass("fa-spinner fa-spin");
            for(var i = 0; i < uploaderArray.length; i++) {
                uploaderArray[i].startUpload();
			}
		});

        function Uploader(file) {
            var self = this;
            this._file = file;
            this._xhr = new XMLHttpRequest();
            this._xhr.addEventListener("load", transferComplete);
            this._xhr.upload.addEventListener("progress", updateProgress);
            this._xhr.upload.addEventListener("error", transferFailed);

            // uploadList에 업로드 아이템을 하나 추가한다.
			var tr = document.createElement("tr");
			var fileName = document.createElement("td");
			var fileSize = document.createElement("td");
			var progress = document.createElement("td");
			var progressDiv = document.createElement("div");
			var progressBarDiv = document.createElement("div");
            var progressBarSpan = document.createElement("span");
            var deleteTd = document.createElement("td");
            var deleteIcon = document.createElement("i");
            progressBarDiv.setAttribute("class","dynamic-progress-bar progress-bar progress-bar-info progress-bar-striped active");
            progressBarDiv.setAttribute("role","progressbar");
            progressBarDiv.setAttribute("aria-valuenow","0");
            progressBarDiv.setAttribute("aria-valuemin","0");
            progressBarDiv.setAttribute("aria-valuemax","100");
            progressBarDiv.setAttribute("style","width: 0%");
            progressBarDiv.textContent = "0%";
            progressBarSpan.setAttribute("id","current-progress");
            progressBarDiv.append(progressBarSpan);
            progressDiv.setAttribute("class","progress");
            progressDiv.append(progressBarDiv);

			fileName.innerHTML = this._file.name;
            fileSize.innerHTML = numToDataUnit(this._file.size);
            progress.append(progressDiv);

            deleteIcon.setAttribute("class","fa fa-times fa-lg");
            deleteIcon.setAttribute("aria-hidden","true");
            deleteTd.append(deleteIcon);

            tr.append(fileName);
            tr.append(fileSize);
            tr.append(progress);
            tr.append(deleteTd);
            $(".fileUploadBody").append(tr);

            // 업로드를 시작시킨다.
            this.startUpload = function () {
                var fileObj = new Object();
                fileObj = this._file;
                var formData = new FormData();
                formData.append("uploadFile", this._file);
                formData.append("nodeId", selectedNode);
                var xhr = self._xhr;
                xhr.open("POST", "/file/uploadFile", true);
                $.ajax({
                    url: '/file/duplicatedFileCheck',
                    data: {
                        "fileName": this._file.name,
						"nodeId": selectedNode
                    },
                    type: 'POST',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    success: function (result) {
                        if(result == "T") {
                            xhr.send(formData);
						} else {
                            self._xhr.abort();
                            self._removeUploadItem();
                            var blob = fileObj.slice(0, -1, fileObj.type);
                            var fileName = getFileName(fileObj.name);
                            var fileExt = getFileExtension(fileObj.name);
                            var newFile = new File([blob], fileName+"_d"+fileExt, {type: fileObj.type});
                            var uploader = new Uploader(newFile);
                            uploader.startUpload();
						}
                    }
                });
            }

            deleteIcon.onclick = function(){
                self._xhr.abort();
                self._removeUploadItem();
			}

            this._removeUploadItem = function () {
                for(var i = 0; i < uploaderArray.length; i++){
                    if(this._file.name == uploaderArray[i]._file.name){
                        uploaderArray.splice(i,1);
					}
				}
                tr.remove();
            }

            // AJAX 데이터가 전송되는 동안 수시로 발생하는 이벤트로 진행 과정을 출력한다.
            function updateProgress(evt) {
                if (evt.lengthComputable) {
                    var percentComplete = Math.ceil(evt.loaded / evt.total * 100);
                    progressBarDiv.setAttribute("style","width: "+percentComplete+"%");
                    progressBarDiv.textContent = percentComplete+"%";
                }
            }

            // 한 파일 업로드가 완료되면 호출되는 이벤트로 성공시 고유 값(이 예제에서는 파일 이름)이 반환된다.
            function transferComplete() {
                if (this.status == 200) {
                    progressBarDiv.textContent = "Success";
                    var result = new Array();
                    result.push(JSON.parse(this.responseText));
                    fileTable.rows.add(result).draw();
                    var completeCnt = Number($(".completeCnt").text())+1;
                    $(".completeCnt").text(completeCnt);

                    $("#lightgallery").data('lightGallery').destroy(true);
                    $("#lightgallery").lightGallery();
                    setFileAdded();
                } else {
                    progressBarDiv.setAttribute("class","dynamic-progress-bar progress-bar progress-bar-danger progress-bar-striped active");
                    progressBarDiv.textContent = "Fail";
                }
                if($(".completeCnt").text() == $(".totalCnt").text()) {
                    $(".uploadStart-icon").addClass("fa-floppy-o");
                    $(".uploadStart-icon").removeClass("fa-spinner fa-spin");
					$(".uploadButtonLabel").text("완료");
				}
            }

            function transferFailed(evt) {
                progressBarDiv.setAttribute("class","dynamic-progress-bar progress-bar progress-bar-danger progress-bar-striped active");
                progressBarDiv.textContent = "Fail";
                console.log("An error occurred while transferring the file.");
                $(".uploadStart").css("display","none");
            }
        }

        numToDataUnit = function(fileSize) {
            var size = fileSize;
            var dataUnit = 0;
            while(true) {
                if(size >= 1024) {
                    size = (size/1024).toFixed(2);
                    dataUnit++;
                } else if(size < 1024 && dataUnit == 0){
                    size = 1;
                    break;
                } else {
                    break;
                }
            }
            var unit = "";
            switch(dataUnit) {
                case 0:
                case 1:
                    unit = "KB";
                    break;
                case 2:
                    unit = "MB";
                    break;
                case 3:
                    unit = "GB";
                    break;
                case 4:
                    unit = "TB";
                    break;
            }
            return size + " " + unit;
        }

        //*******************************************
        /*  FILE MANAGER
        /********************************************/
        if($('#tree-file-manager').length > 0) {

            // file manager datatable
            fileTable = $('#datatable-file-manager').DataTable({
                bFilter: false,
                bInfo: false,
                paging: false,
                dom: 'T<"clear">',
                tableTools: {
                    "sRowSelect": "os",
                    "aButtons": [ ]
                },
                "language": {
                    "emptyTable": "파일이 없습니다~!"
                }
            });

            fileTable.clear().draw();

            $.ajax({
                url: '/file/selectJson',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                    // file manager tree
                    jstree = $('#tree-file-manager').jstree({
                        'core' : {
                            'data' : JSON.parse(result),
                            "check_callback" : true,
                            "multiple" : false,
							"themes" : {
                                "name": "proton",
                                "dots" : true,
                                "icons": true,
                                "url"  : true,
                                "dir"  : "${contextRoot}/assets/js/plugins/tree/themes/"
							}
                        },
                        'plugins' : ["types", "contextmenu"],
                        'types' : {
                            'default' : {
                                'icon' : 'fa fa-folder'
                            }
                        }

                    }).on('select_node.jstree', function(e, data) {
                        var node = data.instance.get_node(data.selected);
                        unCheckSelectAll();
                        $(".prev-image").css("display","none");
                        // since multiple selection is disabled, it's ok not to iterate array (data.selected)
                        if(data.selected == 'root') {
                            fileTable.clear().draw();
                            $(".file-top-menu").attr("disabled","disabled");
                            $(".file-top-menu-upload").attr("disabled","disabled");
							$(".file-top-menu-select").attr("disabled","disabled");
                            setFileAdded();
                            $("#lightgallery").empty();
                        } else {
                            selectedNode = data.selected.toString();
                            if(fileListImageStatus){
                                $(".file-top-menu-upload").removeAttr("disabled");
                                $(".file-top-menu-select").removeAttr("disabled");
                                $(".file-top-menu").attr("disabled","disabled");

							} else {
                                fileViewButton();
							}
                            $.ajax({
                                url: '/file/selectFile',
                                data: {
                                    "nodeId": data.selected.toString()
                                },
                                type: 'POST',
                                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                                success: function (result) {
                                    selectedNode = data.selected.toString();
                                    var fileArray = new Array();
                                    for(var i = 0; i < result.length; i++) {
                                        fileArray.push(result[i]);
                                    }
                                    fileTable.clear().rows.add(fileArray).draw();
                                    setFileAdded();
                                }
                            });
                        }
                    });
                }
            });

            $('#datatable-file-manager tbody').on( 'click', 'tr', function (e) {
                if(fileTable.rows(".DTTT_selected").data().length == 1) {
                    var fileName = fileTable.rows(".DTTT_selected").data()[0][0].split("&nbsp;")[2];
                    var fileExtention = getFileExtension(fileName);
                    if(fileExtention == '.jpg' || fileExtention == '.jpeg' || fileExtention == '.gif'
						|| fileExtention == '.png' || fileExtention == '.bmp') {
                        $.ajax({
                            url: '/file/selectFilePrevView',
                            data: {
                                "fileName" : fileName,
                                "nodeId" : jstree.jstree('get_selected').toString()
                            },
                            type: 'POST',
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (result) {
                                $(".prev-image-view").attr("src",result);
                                $(".prev-image").css("display","block");
                            }
                        });
					} else {
                        $(".prev-image-view").attr("src","");
                        $(".prev-image").css("display","none");
					}
                }
                dataTableCountCheck();
            });

            $('#datatable-file-manager tbody').on( 'mousedown', 'tr', function (e) {
                // if right click
                if(e.button == 2) {
                    document.oncontextmenu = function() {return false;};

                    if(fileTable.rows().data().length > 0) {
                        $(".file-top-menu").removeAttr("disabled");
                    }
                    //만약 선택이 안되어있다면 선택
                    if(!$(this).hasClass('DTTT_selected')) {
                        fileTable.$('tr.DTTT_selected').removeClass('DTTT_selected');
                        $(this).addClass('DTTT_selected');
                    }
                }
                // else if left click and ctrl/meta key released
                else if((e.button == 0) && !(e.ctrlKey || e.metaKey) ){
                    fileTable.$('tr.DTTT_selected').removeClass('DTTT_selected');
                    $(this).addClass('DTTT_selected');
                }
            });
        }

        function getFileExtension(filename) {
            var _fileLen = filename.length;
            var _lastDot = filename.lastIndexOf('.');
            var _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();
            return _fileExt;
        }

        function getFileName(filename) {
            var _fileLen = filename.length;
            var _lastDot = filename.lastIndexOf('.');
            var _fileName = filename.substring(0, _lastDot).toLowerCase();
            return _fileName;
        }

        $(".delete-confirm-btn").on("click", function(e) {
            deleteFile();
		});

        //개별 다운로드
        menuDownload = function() {
            var fileNameArr = [];
            var rows = $('tr.DTTT_selected');
            var rowData = fileTable.rows(rows).data();
            $("#fileName").val(rowData[0][0].split("&nbsp;")[2]);
            $("#nodeId").val(jstree.jstree('get_selected').toString());
            $("#downloadForm").attr("action","/file/downloadFile");
            $("#downloadForm").submit();
		}

		deleteFile = function(){
            var fileNameArr = [];
            var rows = $('tr.DTTT_selected');
            var rowData = fileTable.rows(rows).data();
            $.each($(rowData),function(key,value){
                fileNameArr.push(value[0].split("&nbsp;")[2]);
            });
            $.ajax({
                url: '/file/deleteFile',
                data: {
                    "fileNameList" : fileNameArr,
                    "nodeId" : jstree.jstree('get_selected').toString()
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                    fileTable.rows(rows).remove().draw();
                    dataTableCountCheck();
                    setFileAdded();
                    $(".delete-modal-btn").click();
                }
            });
		}

        $(".menu-download").on("click", function(e) {
            var fileNameArr = [];
            var rows = $('tr.DTTT_selected');
            var rowData = fileTable.rows(rows).data();
            $.each($(rowData),function(key,value) {
                fileNameArr.push(value[0].split("&nbsp;")[2]);
            });
            $("#fileName").val(fileNameArr);
            $("#nodeId").val(jstree.jstree('get_selected').toString());

            if(fileNameArr.length > 1) {
                $.ajax({
                    url: '/file/downloadZipFile',
                    data: {
                        "fileNameList" : fileNameArr,
                        "nodeId" : jstree.jstree('get_selected').toString()
                    },
                    type: 'POST',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    success: function (result) {
                        alert(result);
                    }
                });
			} else {
                $("#downloadForm").attr("action","/file/downloadFile");
                $("#downloadForm").submit();
			}
        });

        $(".select").on("click", function(){
            if($(".selectIcon").hasClass('fa-square-o')) {
                checkSelectAll();
                dataTableSelectAll();
            } else {
                unCheckSelectAll();
                dataTableUnSelectAll();
            }
            dataTableCountCheck();
        });

        $(".file-top-menu-upload").on("click", function(e){
            if(!$(this)[0].hasAttribute("disabled")){
                $(".uploadStart").prop("disabled",false);
                $(".uploadStart-icon").addClass("fa-floppy-o");
                $(".uploadStart-icon").removeClass("fa-spinner fa-spin");
                $(".completeCnt").text("0");
                $(".uploadButtonLabel").text("전송");

                $("#fileuploadButton").click();
			}
		});

        nodeFileSize = function() {
            var totalSize = 0;
            var result;
            var rowData = fileTable.rows().data();
            $.each($(rowData),function(key,value){
                var size = value[3].split(" ")[0];
                var unit = value[3].split(" ")[1];
                if(unit == 'KB') {
                    totalSize += size/1000;
				} else if(unit == 'MB') {
                    totalSize += size*1;
				} else if(unit == 'GB') {
                    totalSize += size*1000;
				}
				totalSize = totalSize.toFixed(2)*1;
            });

            if(totalSize > 1024) {
                result = totalSize/1000 + "GB";
			} else {
                result = totalSize + "MB";
			}
			$(".nodeFileSize").text(result);
		}

		setFileAdded = function(){
            //전체 갯수 설정
            $(".nodeFileCount").text(fileTable.rows().data().length);
            //전체 용량 설정
            nodeFileSize();

            if(fileTable.rows().data().length > 0) {
                $("#datatable-file-manager td").contextmenu({
                    target: '#contextMenuFileManager',
                    onItem: function(context, e) {
                        if($(e.target).text() == ' Download') {
                            menuDownload();
                        } else if($(e.target).text() == ' Delete') {
                            deleteFile();
                        }
                    }
                });
            }
		}

        checkSelectAll = function(){
            $(".selectIcon").removeClass('fa-square-o');
            $(".selectIcon").addClass('fa-check-square-o');
        }
        unCheckSelectAll = function(){
            $(".selectIcon").removeClass('fa-check-square-o');
            $(".selectIcon").addClass('fa-square-o');
        }
        dataTableSelectAll = function(){
            fileTable.$('tr').addClass('DTTT_selected');
        }
        dataTableUnSelectAll = function(){
            fileTable.$('tr').removeClass('DTTT_selected');
        }
        dataTableCountCheck = function(){
            if(fileTable.rows(".DTTT_selected").data().length > 0) {
                $(".file-top-menu").removeAttr("disabled");
            } else {
                $(".file-top-menu").attr("disabled","disabled");
            }
		}

		$(".image-view-button").on('click', function(){
            fileListImageStatus = false;
			$(".image-view-button").css("color","#fff");
            $(".image-view-button").css("background-color","#626262");
            $(".image-view-button").css("border-color","#555555");

            $(".list-view-button").css("color","#333");
            $(".list-view-button").css("background-color","#e6e6e6");
            $(".list-view-button").css("border-color","#adadad");

            $(".file-image-view").css("display","block");
            $(".file-list-view").css("display","none");
            $(".file-list-image-toggle").attr("disabled","disabled");
            fileViewButton();
		});

        $(".list-view-button").on('click', function(){
            fileListImageStatus = true;
            $(".list-view-button").css("color","#fff");
            $(".list-view-button").css("background-color","#626262");
            $(".list-view-button").css("border-color","#555555");

            $(".image-view-button").css("color","#333");
            $(".image-view-button").css("background-color","#e6e6e6");
            $(".image-view-button").css("border-color","#adadad");

            $(".file-list-view").css("display","block");
            $(".file-image-view").css("display","none");
            if(selectedNode != 'root' && selectedNode != "") {
                dataTableUnSelectAll();
                $(".file-top-menu-upload").removeAttr("disabled");
                $(".file-top-menu-select").removeAttr("disabled");
			}
        });

        fileViewButton = function(){
            $("#lightgallery").empty();
            $.ajax({
                url: '/file/selectFilePath',
                data: {
                    "nodeId": selectedNode
                },
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (result) {
                    var str = "";
                    for(var i = 0; i < result.length; i++) {
                        str += '<li data-src="${contextRoot}'+result[i].split(",")[1]+'" data-sub-html="<h4>'+result[i].split(",")[0]+'</h4>">';
                        str += '<a href="" style="width:16.6666%">';
                        str += '<img class="img-responsive" src="${contextRoot}'+result[i].split(",")[2]+'">';
                        str += '<div class="demo-gallery-poster">';
                        str += '<img src="${contextRoot}/assets/js/plugins/light-gallery/img/zoom.png">';
                        str += '</div></a></li>';
                    }
                    $("#lightgallery").append(str);
                    $("#lightgallery").data('lightGallery').destroy(true);
                    $("#lightgallery").lightGallery({
						mode: 'lg-slide-skew-rev',
                        actualSize: false,
						speed: 300,
						share: false,
                        pause: 2000
					});
                }
            });
        }
    });
</script>