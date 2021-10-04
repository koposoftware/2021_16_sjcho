package kr.ac.bank.util;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SendSMS {
	
	public static String autoTranInfoPhone(String phone) {
		
		String ranNo = RandomNO.getRanNo(6, 1);
		
		String api_key = "NCSYPTNBUIL12T6I";
	    String api_secret = "MJBLDTP2MEQBH6UTOO4C8F5D1PIEO94Q";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone); //받는 사람
	    params.put("from", "01025235526"); //보내는 사람
	    params.put("type", "LMS");
	    params.put("text", "안녕하세요. 오픈뱅킹 서비스 제공을 위한 인증 절차입니다.\n"
	    					+ "인증번호 : " + ranNo);
	    params.put("app_version", "test app 1.2"); // application name and version
	    
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	    } catch (CoolsmsException e) {
	      System.out.println("에러인가");
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    
	    
	    System.out.println("랜덤 수 : " + ranNo);
	    return ranNo ;
	}
}
