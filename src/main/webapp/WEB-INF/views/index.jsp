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
</head>
<body>
	<div style="text-align: center;">
		<h2>유기동물 정보 조회</h2>
		<div>
			총 ${total} 건의 유기동물정보가 존재합니다.
		</div>
		<div style="width: 960px; display: flex; flex-direction: row; align-items: center;">
		<c:forEach items="${datas}" var="one">
				<div style="background: #8977ad; width: 25%; margin: 5px;">
					${one.kindCd}
					<p>관할기관 : ${one.orgNm}</p> 
					<p>발견장소 : ${one.happenPlace}</p>
					<img src="${one.filename}">
				</div>
		</c:forEach>
		</div>
	</div>
</body>
</html>