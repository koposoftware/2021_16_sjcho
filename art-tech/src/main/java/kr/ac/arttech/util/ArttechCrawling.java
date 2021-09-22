package kr.ac.arttech.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class ArttechCrawling {
	
	public static List<Map<String, String>> getArttechNews() {
		List<Map<String, String>> newsList = new ArrayList<Map<String,String>>();
		
		try {
			
			//url
			String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=%EC%95%84%ED%8A%B8%ED%85%8C%ED%81%AC";
			
			//html 파싱
			Document doc = Jsoup.connect(url).get(); //connection 생성
			
			//요소 탐색
			Elements elements = doc.select(".list_news li");
			for(Element element : elements) {
				Map<String, String> map = new HashMap<String, String>();
				
				Elements newsTitle = element.select(".news_tit");
				String title = newsTitle.attr("title");
				String newsLink = newsTitle.attr("href");
				
				Elements imgTag = element.select(".dsc_thumb img");
				String imgLink = imgTag.attr("src");
				
				//System.out.println("title : " + title);
				//System.out.println("newsLink : " + newsLink);
				//System.out.println("imgLink : " + imgLink);
				map.put("title", title);
				map.put("newsLink", newsLink);
				map.put("imgLink", imgLink);
				
				newsList.add(map);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return newsList;
	}
}
