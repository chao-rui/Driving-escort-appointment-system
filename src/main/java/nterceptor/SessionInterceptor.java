package nterceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import org.slf4j.MDC;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        HttpSession session = request.getSession();
        Object emp_Code = session.getAttribute("emp_Code");
        boolean result = true;
        // 判断session是否有效
        if (emp_Code != null) {
            String xrq = request.getHeader("X-Requested-With");
            if (xrq == null) {
                response.setContentType("text/html");
                response.setCharacterEncoding("utf-8");
                PrintWriter out = response.getWriter();
                StringBuilder builder = new StringBuilder();
                builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
                builder.append("top.window.location.href='" + request.getContextPath() + "/timeout';");
                builder.append("</script>");
                out.print(builder.toString());
                out.close();
            } else {
                response.setStatus(500);
                response.setHeader("sessionStatus", "timeout");
                response.sendError(500, "$%errorCode=9999%$");
            }
            result = false;
        } else {
            // 用户ID
            String strUserCd = (String) emp_Code;
            // 客户端地址
            String strIp = request.getRemoteAddr();
            // sessionID
            String sessionId = request.getSession().getId();

            MDC.put("userCd", strUserCd);
            MDC.put("ip", strIp);
            MDC.put("sessionId", sessionId);
        }
        return result;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
