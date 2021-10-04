package kr.ac.artTechManager.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.rosuda.REngine.Rserve.RserveException;

public class LogFileReader {
	
	private File rw = null;
	private String filePath = "C:\\art-tech\\logs\\goods-click" ;
	private File[] fileList = null;
	
	public LogFileReader() throws RserveException{
		rw = new File(filePath);
		fileList = rw.listFiles();
	}
	
	//작품별 클릭 수
	public Map<String, Object> getGoodsClickGraph() throws IOException {
		Map<String, Integer> map = new HashMap<String, Integer>(); //데이터
		List<String> keySetList = null; //key 내림차순(클릭 수 기준)
		//로그파일 읽기
		
		for(File file : fileList) {
			if(file.exists()) {
				BufferedReader inFile = new BufferedReader(new FileReader(file));
				String line = null;
				while((line = inFile.readLine())!= null) {
					if(line.contains("CobuyingController.java:40")) {
						System.out.println(line);
						String artworkInfoId = line.split(" ")[4] ;
						
						if(map.size() == 0 || ! map.containsKey(artworkInfoId)) {
							map.put(artworkInfoId, 1);
						
						}else if(map.containsKey(artworkInfoId)){
							map.put(artworkInfoId, map.get(artworkInfoId) + 1);
						}
					}
				}
			}
		}
		
		//value를 기준으로 내림차순 정렬
		keySetList = new ArrayList<String>(map.keySet());
		
		Collections.sort(keySetList, (o1, o2) -> (map.get(o2).compareTo(map.get(o1))) );
		for(String key : keySetList) {
			System.out.println("key : " + key + " / " + "value : " + map.get(key));
		}
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("data", map);
		resultMap.put("keyList", keySetList);
		
		return resultMap;
	} //클릭수 함수 
	
	//로그인 시간
	public LinkedHashMap<String, Integer> getLoginTime() throws IOException {
		Map<String, Integer> map = new HashMap<String, Integer>(); //데이터
		
		for(File file : fileList) {
			if(file.exists()) {
				BufferedReader inFile = new BufferedReader(new FileReader(file));
				String line = null;
				while((line = inFile.readLine())!= null) {
					if(line.contains("MemberController.java:86")) {
						String time = line.split(" ")[1].split(":")[0];
						if(map.size() == 0 || ! map.containsKey(time)) {
							map.put(time, 1);
						}else if(map.containsKey(time)) {
							map.put(time, map.get(time) + 1);
						}
					}
				}
			}
		}
		
		//key기준으로 오름차순 정렬
		List<Map.Entry<String, Integer>> entries = new LinkedList<>(map.entrySet());
		Collections.sort(entries, (o1, o2) -> o1.getKey().compareTo(o2.getKey()));
		
		LinkedHashMap<String, Integer> result = new LinkedHashMap<>();
		for(Map.Entry<String, Integer> entry : entries) {
			result.put(entry.getKey(), entry.getValue());
		}
		
		
		return result;
	}
	
	//로그인 많이 한 사람 
	public Map<String, Object> getLoginTopMember() throws IOException {
		Map<String, Integer> map = new HashMap<String, Integer>(); //데이터
		List<String> keySetList = null; //key 내림차순(클릭 수 기준)
		//로그파일 읽기
		for(File file : fileList) {
			if(file.exists()) {
				BufferedReader inFile = new BufferedReader(new FileReader(file));
				String line = null;
				while((line = inFile.readLine())!= null) {
					if(line.contains("MemberController.java:86")) {
						String memberId = line.split(" ")[4].split(":")[1];
						if(map.size() == 0 || ! map.containsKey(memberId)) {
							map.put(memberId, 1);
						}else if(map.containsKey(memberId)) {
							map.put(memberId, map.get(memberId) + 1);
						}
					}
				}
			}
		}
		
		//value를 기준으로 내림차순 정렬
		keySetList = new ArrayList<String>(map.keySet());
		
		Collections.sort(keySetList, (o1, o2) -> (map.get(o2).compareTo(map.get(o1))) );
		for(String key : keySetList) {
			System.out.println("key : " + key + " / " + "value : " + map.get(key));
		}
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("data", map);
		resultMap.put("keyList", keySetList);
		System.out.println("data : " + map.toString());
		System.out.println("keyList : " + keySetList.toString());
		return resultMap;
		
	}
}
