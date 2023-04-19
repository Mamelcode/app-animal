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
<link
	href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro-v6@44659d9/css/all.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro@4cac1a6/css/all.css" />
</head>
<body>
	<div>
		<div class="title">
			<a href="/index"><i class="fa-light fa-shield-dog"></i>보듬</a>
			<div>
				<form action="/index" method="get">
					<input class="input_date" type="date" name="bgnde"
						value="${param.bgnde eq null ? '' : param.bgnde}" /> <span
						style="color: white; margin: 0px 5px; font-size: 20px;">~</span> <input
						class="input_date" type="date" name="endde"
						value="${param.endde eq null ? '' : param.endde}" /> <select
						name="upr_cd">
						<option value="">전국</option>
						<c:forEach items="${city}" var="one">
							<option value="${one.orgCd}"
								${param.upr_cd eq one.orgCd ? 'selected' : ''}>${one.orgdownNm}</option>
						</c:forEach>
					</select> <select name="upkind">
						<option value="" ${param.upkind eq '' ? 'selected' : '' }>전체</option>
						<option value="417000"
							${param.upkind eq '417000' ? 'selected' : '' }>강아지</option>
						<option value="422400"
							${param.upkind eq '422400' ? 'selected' : '' }>고양이</option>
						<option value="429900"
							${param.upkind eq '429900' ? 'selected' : '' }>기타</option>
					</select>
					<button type="submit">조회</button>
				</form>
			</div>
		</div>
		<%-- 상단 --%>

		<%-- 상세보기 --%>
		<div class="detail_main">
			<%-- 동물정보 --%>
			<div class="detail_info">
				<div class="detail_img">
					<img src="${item.filename}">
				</div>
				<div class="detail_box">
					<ul>
						<li><span>품 종 </span>: ${item.kindCd}</li>
						<li><span>성 별 </span>: ${item.sexCd }</li>
						<li><span>나 이 </span>: ${item.age }</li>
						<li><span>체 중 </span>: ${item.weight }</li>
						<li><span>관할기관 </span>: ${item.orgNm}</li>
						<li><span>발견날짜 </span>: ${item.happenDt}</li>
						<li><span>발견장소 </span>: ${item.happenPlace}</li>
					</ul>
				</div>
				<c:choose>
					<c:when test="${doc.lng != null}">
						<div id="map"
							style="width: 500px; height: 400px; margin-bottom: 10px;"></div>
						<script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?
						appkey=	f11424bc80cb6f3ec465b99e25073db7"></script>
						<script>
							let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = { 
						        center: new kakao.maps.LatLng(${doc.lng}, ${doc.lat}), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    };
			
							let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
							// 마커가 표시될 위치입니다 
							let markerPosition  = new kakao.maps.LatLng(${doc.lng}, ${doc.lat}); 
				
							// 마커를 생성합니다
							let marker = new kakao.maps.Marker({
							    position: markerPosition
							});
				
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						</script>
					</c:when>
					<c:otherwise>
						<h3 style="color: red; margin-bottom: 20px;">지도 정보가 존재하지
							않습니다.</h3>
					</c:otherwise>
				</c:choose>
			</div>

			<%-- 응원영역 --%>
			<div class="detail_comment">
				<h2>
					<i class="fa-solid fa-heart"></i>응원의 한마디 (${fn:length(messages)} 건)
					<span id="refresh" style="margin-left: 5px; cursor: pointer;">
					<i class="fa-sharp fa-light fa-arrows-rotate"></i></span>
				</h2>

				<script type="text/javascript">
					const getMessages = function() {
						const xhr = new XMLHttpRequest();
						xhr.open("get", "/api/refresh?no="+${item.desertionNo}, true);
						xhr.send();
						xhr.onreadystatechange=function(){
							if(xhr.readyState === 4) {
								const json = JSON.parse(xhr.responseText);// 아마 객체 배열일 듯
								const messages = document.querySelector("#messages");
								messages.innerHTML = "";
								for(let o of json) {
									console.log(o.body);
									
									messages.innerHTML += "<div class=\"comment_text\"><div><h4>"+ o.body +
									"</h4></div><div><a><i class=\"fa-regular fa-xmark\"></i></a></div></div>";
								}
							}
						}
					};
					
					document.querySelector("#refresh").onclick = getMessages;
					//setInterval(getMessages, 2000); 2초마다 해당함수를 불러온다
				</script>


				<div>
					<form action="/message" method="post">
						<input type="hidden" name="target" value="${item.desertionNo}">

						<textarea name="body" placeholder="응원을 작성하세요." rows="8" cols="80"></textarea>

						<div>
							<input type="password" name="pass"
								placeholder="비밀번호를 입력하세요. (필수)" required="required" />
							<button type="submit">응원하기</button>
						</div>
					</form>
				</div>
				
				<div id="messages">
					<c:forEach items="${messages}" var="msg">
						<div class="comment_text">
							<div>
								<h4>${msg.body}</h4>
							</div>
							<div>
								<a><i class="fa-regular fa-xmark"></i></a>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<%-- 응원영역 끝! --%>
		</div>
		<%-- 상세보기 끝! --%>

	</div>
</body>
</html>