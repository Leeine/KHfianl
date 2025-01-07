package kr.or.erp.approve.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.erp.approve.model.service.approveService;
import kr.or.erp.approve.model.vo.Document;


@Controller
@RequestMapping("/approve")
public class appoveController {
	
	@Autowired
    private approveService approveService; 
		
	
	@GetMapping("/insert")
    public String listDocument(Model model) {
        ArrayList<Document> list = approveService.selectDocumentList();
        
        
        model.addAttribute("documentList", list);

        return "approve/insert"; 
    }
	
    
	
	
}
