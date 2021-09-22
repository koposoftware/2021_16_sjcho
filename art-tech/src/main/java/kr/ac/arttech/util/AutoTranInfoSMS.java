package kr.ac.arttech.util;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class AutoTranInfoSMS {
	
	public static void autoTranInfoPhone(String phone, String msg) {
		
		String api_key = "NCSYPTNBUIL12T6I";
	    String api_secret = "MJBLDTP2MEQBH6UTOO4C8F5D1PIEO94Q";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone); //받는 사람
	    params.put("from", "01025235526"); //보내는 사람
	    params.put("type", "LMS");
	    params.put("text", "안녕하세요. 하나아트입니다.\n"
	    					+ "설정한 계좌에서 예치금이 자동이체 되었습니다. \n\n"
	    					+ msg);
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
}
