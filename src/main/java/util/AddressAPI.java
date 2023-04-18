package util;

import java.net.URI;import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import com.google.gson.Gson;

import data.address.AddressDocument;
import data.address.AddressResponseResult;

public class AddressAPI {
	public static AddressDocument getAddress(String query) {
		try {
			String target = "https://dapi.kakao.com/v2/local/search/address";
			
			String queryString = "query=" + URLEncoder.encode(query, "utf-8");

			URI uri = new URI(target + "?" + queryString);

			// HttpClient 객체를 활용하는 방식
			HttpClient client = HttpClient.newHttpClient();
			HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization", "KakaoAK 256bb0821ee572161edc97b34be40012").GET().build();
			HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

			Gson gson = new Gson();
			AddressResponseResult result = gson.fromJson(response.body(), AddressResponseResult.class);
			
			return result.getDocuments()[0];

		} catch (Exception e) {
			e.printStackTrace();
			
			return null;
		}
	}
}
