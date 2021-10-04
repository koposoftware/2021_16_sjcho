package kr.ac.bank.util;

import java.io.IOException;
import java.io.Reader;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.ibatis.io.Resources;

public class SecurityUtil {
	
	private final static String resource = "config/security.properties";
	private static Properties properties = null;
	private static Reader reader = null;
	
	private static String AES256Key; //암/복호화를 위한 키값
	
	public SecurityUtil() {
		properties = new Properties();
		try {
			reader = Resources.getResourceAsReader(resource);
			properties.load(reader);
			AES256Key = properties.getProperty("AES256Key");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//AES256 암호화
	public String encryptAES256(String str) throws Exception { //키값의 길이가 16이하일 경우 발생
		
		
		String iv = AES256Key.substring(0, 16);
		byte[] keyBytes = new byte[16];
		byte[] b = AES256Key.getBytes("UTF-8");
		int len = b.length;
		if (len > keyBytes.length) {
			len = keyBytes.length;
		}
		System.arraycopy(b, 0, keyBytes, 0, len);
		Key keySpec = new SecretKeySpec(keyBytes, "AES");
		
		//암호화
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
		byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
		
		String enStr = new String(Base64.encodeBase64(encrypted));
		return enStr;
	}
	
	//AES256 복호화
	public String decryptAES256(String str) throws Exception {
		String iv = AES256Key.substring(0, 16);
		byte[] keyBytes = new byte[16];
		byte[] b = AES256Key.getBytes("UTF-8");
		int len = b.length;
		if (len > keyBytes.length) {
			len = keyBytes.length;
		}
		System.arraycopy(b, 0, keyBytes, 0, len);
		Key keySpec = new SecretKeySpec(keyBytes, "AES");
		
		
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
		byte[] byteStr = Base64.decodeBase64(str.getBytes());
		return new String(c.doFinal(byteStr), "UTF-8");
	}
	
	
	//Secure Hash Algorithm
	public static String encryptSHA256(String str){
	
	String sha = "";
	
	try{
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.update(str.getBytes());
		byte byteData[] = sh.digest();
		StringBuffer sb = new StringBuffer();
		for(int i = 0 ; i < byteData.length ; i++){
		sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
		}
	
		sha = sb.toString();
	
	}catch(NoSuchAlgorithmException e){
		//e.printStackTrace();
		System.out.println("Encrypt Error - NoSuchAlgorithmException");
		sha = null;
	}
	
		return sha;
	} 
}
