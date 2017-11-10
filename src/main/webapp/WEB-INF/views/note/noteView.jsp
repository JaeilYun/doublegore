<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 상세화면 시작 -->
<div class="main-content note-view-div" style="display: none; padding: 10px 3px 10px 3px;">
	<div class="row">
		<div class="col-md-12">
			<!-- BASIC INPUT -->
			<div style="padding-top: 26px;padding-bottom: 40px;">
				<div class="widget-content" style="text-align: center;">
					<div style="height: 50px;">
						<div class="col-md-6" style="text-align: left; float: left">
							<div class="btn-group" style="float: left;">
								<button type="button" class="btn btn-clean note-view-menu-btn main-back" style="color: #bbb;font-size: 18px;">메뉴</button>
							</div>
						</div>
						<div class="col-md-6" style="text-align: right; float: right">
							<div class="btn-group" style="float: right;">
								<button type="button" class="btn btn-clean note-view-edit-btn note-update" style="color: rgba(75, 168, 75, 0.5);font-size: 18px;">수정</button>
								<button type="button" class=" btn btn-clean note-view-delete-btn note-view-delete" style="color: rgba(219, 56, 51, 0.5);font-size: 18px;">삭제</button>
							</div>
						</div>
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
<!-- 상세화면 끝 -->
