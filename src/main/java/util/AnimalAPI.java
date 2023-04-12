package util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import com.google.gson.Gson;

import data.animal.AnimalResponse;
import data.animal.AnimalResponseResult;

public class AnimalAPI {
	
	// OPEN API 연동해서 데이터 받아와서 파싱해서 컨트롤러로 이동
	public synchronized static AnimalResponse getAnimals(String upkind, String upr_cd, String pageNo, 
			String bgnde, String endde) {
		try {
			String target = "http://apis.data.go.kr/1543061/abandonmentPublicSrvc/abandonmentPublic";
			//String queryString= "?serviceKey=IW2U%2FqUpMRhESj1g0MEVFRu%2BSXW5ysrBX%2FBASDOXsa%2FU8uzSE%2B5%2FWqzS3J30O5DcSJPTw0E%2FaykJb9cwz5eyww%3D%3D&_type=json";
			
			Map<String, String> params = new LinkedHashMap<>();
			
			params.put("serviceKey", "IW2U%2FqUpMRhESj1g0MEVFRu%2BSXW5ysrBX%2FBASDOXsa%2FU8uzSE%2B5%2FWqzS3J30O5DcSJPTw0E%2FaykJb9cwz5eyww%3D%3D");
			params.put("numOfRows", "10");
			params.put("_type", "json");
			
			params.put("upkind", upkind == null ? "" : upkind);
			params.put("upr_cd", upr_cd == null ? "" : upr_cd);
			params.put("pageNo", pageNo == null ? "" : pageNo);
			params.put("bgnde", bgnde == null ? "" : bgnde);
			params.put("endde", endde == null ? "" : endde);
			
			String queryString = QueryStringBuilder.build(params);
			
			/*
			// 페이징 처리시 필요한 데이터
			queryString = queryString + "&numOfRows=10&pageNo=" + pageNo;
			
			// 품종 선택시 필요한 데이터
			if(upkind != null) {
				queryString = queryString + "&upkind=" + upkind; 
			}
			
			// 도시 선택시 필요한 데이터
			if(upr_cd != null) {
				queryString = queryString + "&upr_cd=" + upr_cd;
			}
			*/
			URI uri = new URI(target+ "?" +queryString);
			
			// HttpRequest 객체를 활용하는 방식
			HttpClient client = HttpClient.newHttpClient();
			HttpRequest req = HttpRequest.newBuilder().uri(uri).GET().build();
			HttpResponse<String> resp =  client.send(req, BodyHandlers.ofString());
			
			Gson gson = new Gson();
			AnimalResponseResult result = gson.fromJson(resp.body(), AnimalResponseResult.class);
			
			return result.getResponse();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
