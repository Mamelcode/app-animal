package util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import data.sido.Sido;
import data.sido.SidoResponse;

public class SidoAPI {
	// OPEN API 연동해서 데이터 받아와서 파싱해서 컨트롤러로 이동
		public synchronized static SidoResponse getSido() {
			try {
				String target = "http://apis.data.go.kr/1543061/abandonmentPublicSrvc/sido";
				//String queryString= "?serviceKey=IW2U%2FqUpMRhESj1g0MEVFRu%2BSXW5ysrBX%2FBASDOXsa%2FU8uzSE%2B5%2FWqzS3J30O5DcSJPTw0E%2FaykJb9cwz5eyww%3D%3D&_type=json";
				
				Map<String, String> params = new HashMap<>();
				params.put("serviceKey", "IW2U%2FqUpMRhESj1g0MEVFRu%2BSXW5ysrBX%2FBASDOXsa%2FU8uzSE%2B5%2FWqzS3J30O5DcSJPTw0E%2FaykJb9cwz5eyww%3D%3D");
				params.put("_type", "json");
				params.put("numOfRows", "17");
				
				String queryString = QueryStringBuilder.build(params);
				
				URI uri = new URI(target+ "?" +queryString);
				
				// HttpRequest 객체를 활용하는 방식
				HttpClient client = HttpClient.newHttpClient();
				HttpRequest req = HttpRequest.newBuilder().uri(uri).GET().build();
				HttpResponse<String> resp =  client.send(req, BodyHandlers.ofString());
				
				Gson gson = new Gson();
				Sido result = gson.fromJson(resp.body(), Sido.class);
				
				return result.getResponse();
			}catch(Exception e) {
				e.printStackTrace();
				return null;
			}
		}
}
