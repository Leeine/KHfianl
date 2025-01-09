package kr.or.erp.approve.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
    
	@ResponseBody
	@GetMapping(value="/type", produces = "application/json;charset=UTF-8")
	public Document type(Document doc) {
		System.out.println(doc);
		Document type = approveService.typeContent(doc);
				
				
		return type;
	}
	
	
}
