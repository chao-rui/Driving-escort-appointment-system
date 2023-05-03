package serviceimpl;

import org.springframework.stereotype.Service;
import service.EmailService;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

@Service("EmailService")
public class EmailServiceImpl implements EmailService {

    public void sendHtmlEmail(String to,String code) {
        // 配置邮件服务器
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.qq.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // 认证信息
        String username = "wrchao0124@qq.com";
        String password = "tsmaqgoojrzxdhff";

        LocalDate date = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
        String dateString = date.format(formatter);

        String subject="重置密码验证码";
        String htmlContent=
                "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <title>重置密码</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <h1>重置密码</h1>\n" +
                "    <p>亲爱的用户，您好！</p>\n" +
                "    <p>您正在进行重置密码操作。您的验证码为：</p>\n" +
                "    <p style=\"font-size: larger; color: red; font-weight: bolder\">"+code+"</p>\n" +
                "    <p>请在 10 分钟内使用此验证码完成重置密码操作。</p>\n" +
                "    <p>如果您没有进行重置密码操作，请忽略此邮件。</p>\n" +
                "    <p>感谢您对我们的支持！</p>\n" +
                "    <p></p>\n" +
                "    <p>一对一驾驶预约系统团队</p>\n" +
                "    <p>"+dateString+"</p>\n" +
                "</body>\n" +
                "</html>";

        // 创建会话
        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // 创建邮件消息
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject(subject);

            // 设置邮件正文为HTML格式
            message.setContent(htmlContent, "text/html;charset=UTF-8");

            // 发送邮件
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
