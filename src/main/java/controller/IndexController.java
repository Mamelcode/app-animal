package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.animal.AnimalResponse;
import data.sido.SidoResponse;
import util.AnimalAPI;
import util.SidoAPI;

@WebServlet("/index")
public class IndexController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SidoResponse sido = SidoAPI.getSido();
		if(sido != null) {
			req.setAttribute("city", sido.getBody().getItems().getItem());
		}
		
		// 축종코드 : 개 ==> "417000", 고양이 ==> "422400", 기타 ==> "429900"
		String upkind = req.getParameter("upkind");
		String upr_cd = req.getParameter("upr_cd");
		String bgnde = req.getParameter("bgnde");
		String endde = req.getParameter("endde");
		
		if(bgnde != null && bgnde.matches("\\d{4}-\\d{2}-\\d{2}")) {
			bgnde = bgnde.replaceAll("-", "");
		}
		
		if(endde != null && endde.matches("\\d{4}-\\d{2}-\\d{2}")) {
			endde = endde.replaceAll("-", "");
		}
		
		int p;
		if(req.getParameter("pageNo") == null) {
			p = 1;
		}else {
			p = Integer.parseInt(req.getParameter("pageNo"));
		}
		
		String pageNo = p + "";
		AnimalResponse animal = AnimalAPI.getAnimals(upkind, upr_cd, pageNo, bgnde, endde);
		
		if(animal != null) {
			req.setAttribute("datas", animal.getBody().getItems().getItem());
			req.setAttribute("total", animal.getBody().getTotalCount());
		}
		
		
		
		
		
		
		
		
		
		
		int total = animal.getBody().getTotalCount();
		int totalPage = total/10 + (total % 10 > 0 ? 1 : 0);
		int viewPage = 5;
		
		int endPage = (((p-1)/viewPage)+1) * viewPage;
		if(totalPage < endPage) {
		    endPage = totalPage;
		}
		
		int startPage = ((p-1)/viewPage) * viewPage + 1;
		
		req.setAttribute("start", startPage);
		req.setAttribute("last", endPage);
		boolean existPrev = p >= 6;
		boolean existNext = true;
		if(endPage >= totalPage)
		{
			existNext = false;
		}
		
		req.setAttribute("existPrev", existPrev);
		req.setAttribute("existNext", existNext);
		
		req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
	}
}
