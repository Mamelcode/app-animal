<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보호소</title>
<link rel="stylesheet" href="/resource/css/initial.css" />
<link rel="stylesheet" href="/resource/css/style.css" />
</head>
<body>
	<div style="text-align: center;">
		<h2>유기동물 정보 조회</h2>
		<div>
			<form action="/index">
				<select name="upr_cd">
					<option value="">전국</option>
					<c:forEach items="${city}" var="one">
						<option value="${one.orgCd}" ${param.upr_cd eq one.orgCd ? 'selected' : ''}>${one.orgdownNm}</option>
					</c:forEach>
				</select>
				<select name="upkind">
					<option value="" ${param.upkind eq '' ? 'selected' : '' }>전체</option>
					<option value="417000" ${param.upkind eq '417000' ? 'selected' : '' }>강아지</option>
					<option value="422400" ${param.upkind eq '422400' ? 'selected' : '' }>고양이</option>
					<option value="429900" ${param.upkind eq '429900' ? 'selected' : '' }>기타</option>
				</select>
				<button type="submit">조회</button>
			</form>
		</div>
		<div>
			총 ${total} 건의 유기동물정보가 존재합니다.
		</div>
		<div class="show_main">
		<c:forEach items="${datas}" var="one">
				<div class="show_box">
					<div class="show_img">
						<img src="${one.filename}">
					</div>
					<ul>
						<li>${one.kindCd}</li>
						<li>관할기관 : ${one.orgNm}</li> 
						<li>발견장소 : ${one.happenPlace}</li>
					</ul>
				</div>
		</c:forEach>
		</div>
	</div>
	<%-- 페이지 처리 --%>
	<c:set var="sortStatus" value="${empty param.sort ? null : param.sort }" />
	<c:set var="currentPage" value="${empty param.page ? 1: param.page }"/>
	<div>
		<c:forEach begin="${start }" end="${last}" var="idx">
			<c:choose>
				<c:when test="${idx eq currentPage}">
					<a style="color: red;">${idx }</a>
				</c:when>
				<c:otherwise>
					<a href="index?pageNo=${idx}">${idx }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
</body>
</html>