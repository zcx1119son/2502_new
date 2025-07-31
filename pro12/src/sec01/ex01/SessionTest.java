package sec01.ex01;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class SessionTest
 */
@WebServlet("/sess")
public class SessionTest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter pw = response.getWriter();
        HttpSession session = request.getSession();
        session.setAttribute("name", "둘리");
        
        pw.println("<html><body>");
        pw.println("<h1>세션에 이름을 바인딩합니다.</h1>");
        pw.println("<a href='/pro12/test01/session1.jsp'>첫번째 페이지로 이동하기 </a>");
        pw.println("</body></html>"); 
    }

}