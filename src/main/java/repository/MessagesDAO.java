package repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import data.vo.Message;

public class MessagesDAO extends DAO {
	
	// 데이터 등록을 처리할 메서드
	public static int createMessage(String target, String body, String pass) {
		
		SqlSession session = factory.openSession(true);
		Map<String, Object> obj = new HashMap<>();
		obj.put("target", target);
		obj.put("body", body);
		obj.put("pass", pass);
		int result = session.insert("messages.create", obj);
		session.close();
		
		return result;
	}
	
	// 특정 동물에 대한 댓글을 읽어오는 메서드
	public static List<Message> readMessages(String target) {
		
		SqlSession session = factory.openSession();
		List<Message> li = session.selectList("messages.readByTarget", target);
		session.close();
		
		return li;
	}
}
