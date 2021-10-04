package kr.ac.artTechManager.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.artTechManager.service.WriterInfoService;
import kr.ac.artTechManager.vo.WriterInfoVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class WriterInfoController {
	private final WriterInfoService service;
	
	@RequestMapping("/writerRegisterPro")								//IOException - 파일이 없을 때 발생할 에러			
	public String addWriterInfo(WriterInfoVO writerInfo, MultipartFile attachfile, HttpSession session) throws IOException{
		
		String filePath = "C:/art-tech/writerInfo_img";
		
		String orgnFileName = attachfile.getOriginalFilename() ;
		
		//UUID클래스 - (특수문자를 포함한)문자를 랜덤으로 생성, "-"라면 생략으로 대체
		String fileChanName = UUID.randomUUID().toString().replace("-", "") + orgnFileName;
		long fileSize = attachfile.getSize();
		
		writerInfo.setOrgnFileName(orgnFileName);
		writerInfo.setFileChanName(fileChanName);
		writerInfo.setFileSize(fileSize);
		writerInfo.setFilePath(filePath);
		
		//정보 insert
		int result = service.addWriterInfo(writerInfo);
		
		//파일 저장을 위한 File 객체 생성
		if(result == 1) {
			File file = new File(filePath + "/" + fileChanName);
			attachfile.transferTo(file);
			session.setAttribute("register", "success");
			
		}
		
		return "redirect:/manage/writerList";
	}
	
	//작가 리스트
	@GetMapping("/writerList")
	public String writerList(Model model, HttpSession session) {
		String register = (String) session.getAttribute("register");
		session.removeAttribute("register");
		
		List<WriterInfoVO> writerInfoList = service.getWriterInfoList();
		
		model.addAttribute("writerInfoList", writerInfoList);
		model.addAttribute("register", register);
		return "manage/writerList";
	}
	
	//작가 디테일
	@GetMapping("/writerDetail")
	public String writerDetail(String id, Model model) {
		WriterInfoVO writerInfo = service.getWriterInfo(id);
		model.addAttribute("writerInfo", writerInfo);
		
		return "manage/writerDetail";
	}
}
