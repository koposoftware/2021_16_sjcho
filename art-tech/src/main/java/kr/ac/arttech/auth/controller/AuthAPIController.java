package kr.ac.arttech.auth.controller;

import java.util.HashMap;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.arttech.util.RandomNO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RestController
@RequestMapping("/auth")
public class AuthAPIController {
	
	@PostMapping("/smsAuth")
	public String authPhone(String phone) {
		//핸드폰 번호
		String ran = RandomNO.getRanNo(6, 1);
		
		//System.out.println("핸드폰 ran : " + ran);
		
		//여기부터 끝까지 주석
		
		String api_key = "NCSYPTNBUIL12T6I";
	    String api_secret = "MJBLDTP2MEQBH6UTOO4C8F5D1PIEO94Q";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone); //받는 사람
	    params.put("from", "01025235526"); //보내는 사람
	    params.put("type", "SMS");
	    params.put("text", "[아트하나] 인증번호 : " + ran);
	    params.put("app_version", "test app 1.2"); // application name and version
	    
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	    } catch (CoolsmsException e) {
	      System.out.println("에러인가");
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    
		
		return ran;
	}
	
	
	@PostMapping("/emailAuth")
	public String authEmail(String email) {
		
		String mail_id = "whtpwls7777@gmail.com" ;
		String mail_pw = "alvhwkddls124!";
		
		String ran = RandomNO.getRanNo(6, 1);
		
		//SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(mail_id, mail_pw);
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(mail_id));

            //수신자 메일 주소
            message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(email)); 

            // Subject
            message.setSubject("[아트하나] 인증번호 발송 안내 메일입니다."); //메일 제목을 입력

            // Text
            message.setText("인증번호 6자리 : " + ran);    //메일 내용을 입력

            // send the message
            Transport.send(message); ////전송
            
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        } 
		
		return ran;
	}
	
}
