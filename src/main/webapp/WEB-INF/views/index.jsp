<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산책</title>
<link rel="stylesheet" href="/resource/css/initial.css" />
<link rel="stylesheet" href="/resource/css/style.css" />
<link href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro-v6@44659d9/css/all.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro@4cac1a6/css/all.css" />
</head>
<body>
	<div>
		<div class="title">
			<a href="/index"><i class="fa-thin fa-dog-leashed"></i>산책</a>
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
		</div>
			<div class="title_text">
				총 ${total} 건의 동물정보가 존재합니다.
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
	<c:set var="upr_cdStatus" value="${empty param.upr_cd ? null : param.upr_cd }" />
	<c:set var="upkindStatus" value="${empty param.upkind ? null : param.upkind }" />
	<c:set var="currentPage" value="${empty param.pageNo ? 1: param.pageNo }"/>
	
	<%-- prev 처리 --%>
	<div class="page">
		<div class="page_prev">
			<c:choose>
				<c:when test="${existPrev }">
				<a href="index?pageNo=${start - 1}&upkind=${upkindStatus}&upr_cd=${upr_cdStatus}">
				<i style="color: black" class="fa-solid fa-angle-left"></i></a>
				</c:when>
				<c:otherwise>
				<a><i style="color: white;" class="fa-solid fa-angle-left"></i></a>
				</c:otherwise>
			</c:choose>
		</div>
		
		<%-- 넘버링 처리 --%>
		<div class="page_number">
			<c:forEach begin="${start }" end="${last}" var="idx">
				<c:choose>
					<c:when test="${idx eq currentPage}">
						<a style="color: red;">${idx }</a>
					</c:when>
					<c:otherwise>
						<a href="index?pageNo=${idx}&upkind=${upkindStatus}&upr_cd=${upr_cdStatus}">${idx }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		
		<%-- next 처리 --%> 
		<div class="page_next">
			<c:choose>
				<c:when test="${existNext }">
					<a href="index?pageNo=${last + 1}&upkind=${upkindStatus}&upr_cd=${upr_cdStatus}">
					<i style="color: black" class="fa-solid fa-angle-right"></i></a>
				</c:when>
				<c:otherwise>
					<a><i style="color: white;" class="fa-solid fa-angle-right"></i></a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>