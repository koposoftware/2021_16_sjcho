package kr.ac.arttech.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.arttech.notice.service.NoticeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService service;
	
	@RequestMapping("/list")
	public String list(Model model) {
		model.addAttribute("noticeList", service.getNoticeList());
		return "notice/list";
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable("id")String id, Model model ) {
		model.addAttribute("notice",service.getNotice(id) );
		return "notice/detail";
	}
}
