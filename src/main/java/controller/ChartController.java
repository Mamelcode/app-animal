package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import data.animal.AnimalResponse;
import util.AnimalAPI;

@WebServlet("/chart")
public class ChartController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// ==== 5일의 날짜배열 만들기 ====
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String[] de = new String[5];
		for (int i = 0; i < 5; i++) {
			de[4-i] = sdf.format(new Date(System.currentTimeMillis() - 1000 * 60 * 60 * 24 * i));
		}
		req.setAttribute("date", de);
		// ========================
		
		// == 해당날짜의 발생건수 받아오기 ==
		List<Integer> li = new ArrayList<>();
		for (String d : de) {
			AnimalResponse response = AnimalAPI.getAnimals(null, null, null, d, d);
			int tot = response.getBody().getTotalCount();
			li.add(tot);
		}
		// ========================

		// == Json 형태로 데이터 변경하기 ==
		Map<String, Object> map = new LinkedHashMap<>();
		map.put("labels", de);
		map.put("datasets", List.of(Map.of("label", "발생건수", "data", li)));
		Gson gson = new Gson();
		String mapJson = gson.toJson(map);
		// ========================
		
		// 처리결과를 셋팅해주기
		req.setAttribute("mapJson", mapJson);

		// 뷰로 넘겨주는 작업
		req.getRequestDispatcher("/WEB-INF/views/chart.jsp").forward(req, resp);
	}
}
