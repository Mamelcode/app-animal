package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.address.AddressDocument;
import data.animal.AnimalItem;
import data.vo.Message;
import repository.MessagesDAO;
import util.AddressAPI;
import util.AnimalAPI;

@WebServlet("/detail")
public class DetailController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String happenPlace = req.getParameter("happenPlace");
		
		AnimalItem item  = AnimalAPI.findByDesertionNo(no);
		
		
		
		if(item == null) {
			req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
		}else {
			AddressAPI.getAddress(item.getHappenPlace());
			AddressDocument doc = AddressAPI.getAddress(item.getHappenPlace());
						
			List<Message> li = MessagesDAO.readMessages(no);
			
			req.setAttribute("doc", doc);
			req.setAttribute("item", item);
			req.setAttribute("messages", li);
			req.getRequestDispatcher("/WEB-INF/views/detail.jsp").forward(req, resp);
		}
	}
}
