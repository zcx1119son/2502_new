package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ajaxTest2")
public class AjaxTest2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AjaxTest2() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/xml; charset=utf-8");

		String result = "<main>" +
			"<book>" +
				"<title><![CDATA[초보자를 위한 자바 프로그래밍]]></title>" +
				"<writer><![CDATA[인포북스 저 | 이병승]]></writer>" +
				"<image><![CDATA[http://localhost:8090/pro16/image/sury.png]]></image>" +
			"</book>" +
			"<book>" +
				"<title><![CDATA[모두의 파이썬]]></title>" +
				"<writer><![CDATA[길벗 저 | 이승찬]]></writer>" +
				"<image><![CDATA[http://localhost:8090/pro16/image/hoodi.png]]></image>" +
			"</book>" +
		"</main>";

		PrintWriter writer = response.getWriter();
		writer.print(result);
	}
}
