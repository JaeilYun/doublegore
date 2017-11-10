<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 메인화면 시작 -->
<div class="main-content note-list-div" style="display: block;padding: 10px 3px 10px 3px;">
	<div class="row">
		<div class="col-md-12">
			<div style="padding-top: 26px;padding-bottom: 60px;">
				<div class="wedget-content" style="text-align: center;">
					<div class="col-md-3" style="text-align: left;margin-bottom: 5px;">
						<div class="btn-group" style="float: left;">
							<button type="button" class="btn btn-clean note-list-new-btn register-btn" style="color: rgba(75, 168, 75, 0.5);font-size: 18px;">새글</button>
						</div>
					</div>
					<div class="col-md-6">
						<select class="form-control note-select category-list"></select>
					</div>
					<div class="col-md-3" style="text-align: right;">
						<div class="btn-group" style="float: right;">
							<button type="button" class="btn btn-clean note-list-setting-btn setting-btn" style="color: rgba(219, 56, 51, 0.5);font-size: 18px;">설정</button>
						</div>
					</div>
				</div>
			</div>
			<div class="noteList"></div>
			<div style="text-align: center;padding-top: 20px;">
				<ul class="pagination" style="font-size: 20px;"></ul>
			</div>
		</div>
	</div>
	
</div>
<!-- 메인화면 끝 -->