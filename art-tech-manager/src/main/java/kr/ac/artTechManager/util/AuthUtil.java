package kr.ac.artTechManager.util;

import java.util.HashMap;
import java.util.Properties;

import org.json.simple.JSONObject;

import kr.ac.artTechManager.vo.VoteVO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class AuthUtil {
	
	public static void authPhone(VoteVO vote, String phone) {
		//핸드폰 번호
		//여기부터 끝까지 주석
		
		String api_key = "NCSYPTNBUIL12T6I";
	    String api_secret = "MJBLDTP2MEQBH6UTOO4C8F5D1PIEO94Q";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone); //받는 사람
	    params.put("from", "01025235526"); //보내는 사람
	    params.put("type", "LMS");
	    
	    switch (vote.getType()) {
		case "1": //매각 투표하기 
			params.put("text", "안녕하세요 하나아트입니다.  \n"
		    		+ vote.getWriterName() + " 화백의 <" + vote.getTitle() + "> 작품 매입을 "
					+ "원하는 매입자가 나타나 매각을 진행하고자 합니다. \n"
					+ "공동구매 시 동의한 서비스 이용약관 제11조 2항에 의거하여 작품 소유자분들의"
					+ "매각 동의 비율이 50% 초과일 때 매각은 진행됩니다. \n\n"
					+ "하기의 내용을 참고하시어 투표 부탁드립니다." + "\n\n"
					+ "작품명 : " + vote.getTitle() + "\n"
					+ "작가 : " + vote.getWriterName() + "\n"
					+ "투표기간 : " + vote.getStartDate() + " ~ " + vote.getEndDate() + "\n"
					+ "투표링크 : " + vote.getUrl() + "\n"
					+ "투표 비밀번호 : " + vote.getEmailPw()
	    			);
			break;

		case "2": //매각 투표 결과 매각으로 결정
			params.put("text", "안녕하세요 하나아트입니다.  \n"
		    		+ vote.getWriterName() + " 화백의 <" + vote.getTitle() + "> 작품의"
					+ "투표 결과를 공지드립니다. \n\n"
					+ "작품명 : " + vote.getTitle() + "\n"
					+ "작가 : " + vote.getWriterName() + "\n"
					+ "투표기간 : " + vote.getStartDate() + " ~ " + vote.getEndDate() + "\n"
					+ "동의 : " + vote.getAgreeNo() + "\n"
					+ "거부 : " + (vote.getTotalNo() - vote.getAgreeNo()) + "\n"
					+ "동의율 : " + Math.round( ((float) vote.getAgreeNo() / vote.getTotalNo()) * 100) / 1.0 + "%\n"
	    			+ "위와 같이 매각의사 투표 동의율이 과반수가 넘어, 작품매각을 진행할 예정입니다.\n"
					+ "자세한 사항은 홈페이지를 참고하시길 바랍니다."
					);
			break;
		case "3": //투표결과(매각 기각)
			break;
		case "4": //4. 매각대금 분배안내
			
			params.put("text", "[매각대금 분배안내] \n"
					+ "안녕하세요 하나아트입니다. \n"
		    		+ vote.getWriterName() + " 화백의 <" + vote.getTitle() + "> 작품의"
					+ "매각대금 분배를 진행합니다.\n"
		    		+ "분배된 매각대금은 예치금으로 입금되오니 "
					+ "자세한 사항은 홈페이지를 참고하시길 바랍니다."
		    		+ "매각대금 분배가 완료되는 대로 회원님들께 다시 한번 공지드리겠습니다."
					);
			break;
		case "5": //5. 분배완료
			params.put("text", "[매각대금 분배완료 안내] \n"
					+ "안녕하세요 하나아트입니다. \n "
		    		+ vote.getWriterName() + " 화백의 <" + vote.getTitle() + "> "
					+ "작품매각대금 분배가 완료되었습니다.\n"
					+ "최근 코로나 사태의 악화로 인한 제휴사의 사정으로 약 1주일가량 분배가 늦어지게 되어"
					+ "대단히 죄송합니다. \n"
					+ "매각대금 분배금은 홈페이지에서 확인이 가능합니다."
					);
			break;
		}
	    
	    
	    params.put("app_version", "test app 1.2"); // application name and version
	    
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	    } catch (CoolsmsException e) {
	      System.out.println("에러인가");
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    
		
	}
	
	public static void authEmail(VoteVO vote, String email) {
		
		String mail_id = "whtpwls7777@gmail.com" ;
		String mail_pw = "alvhwkddls124!";
		
		
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
            message.setSubject("[아트하나] 매각투표를 위한 안내 이메일입니다."); //메일 제목을 입력

            // Text
            message.setText("안녕하세요 아트하나입니다.  \n "
            		       + vote.getWriterName() + " 화백의 <" + vote.getTitle() + "> 작품 매입을 "
           				   + "원하는 매입자가 나타나 매각을 진행하고자 합니다. \n"
           				   + "공동구매 시 동의한 서비스 이용약관 제11조 2항에 의거하여 작품 소유자분들의"
           				   + "매각 동의 비율이 50% 초과일 때 매각은 진행됩니다. \n\n"
           				   + "하기의 내용을 참고하시어 투표 부탁드립니다." + "\n\n"
           				   + "작품명 : " + vote.getTitle() + "\n"
           				   + "작가 : " + vote.getWriterName() + "\n"
        				   + "투표기간 : " + vote.getStartDate() + " ~ " + vote.getEndDate() + "\n"
        				   + "투표링크 : " + vote.getUrl() + "\n"
        				   + "투표 비밀번호 : " + vote.getEmailPw()
            		);    //메일 내용을 입력

            // send the message
            Transport.send(message); ////전송
            
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        } 
		
	}
}
