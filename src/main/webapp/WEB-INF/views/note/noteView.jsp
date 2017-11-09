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
							<span style="padding: 3px;font-size: 18px;" class="note-view-back-btn">
								<a href="#" class="note-view-menu-btn main-back" style="text-decoration:none !important;color: #bbb;font-weight: 600;">메뉴</a>
							</span>
						</div>
						<div class="col-md-6" style="text-align: right; float: right">
							<span style="padding: 3px;color: #bbb;font-size: 18px;" class="">
								<a href="#" class="note-view-edit-btn note-update" style="text-decoration:none !important;color: rgba(75, 168, 75, 0.5);font-weight: 600;">수정</a>
							</span>
							<span style="padding: 3px;color: #bbb;font-size: 18px;">
								<a href="#" class="note-view-delete-btn note-view-delete" style="text-decoration:none !important;color: rgba(219, 56, 51, 0.5);font-weight: 600;">삭제</a>
							</span>
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
