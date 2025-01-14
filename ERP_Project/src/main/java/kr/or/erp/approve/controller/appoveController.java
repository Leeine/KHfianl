package kr.or.erp.approve.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.erp.approve.model.service.approveService;
import kr.or.erp.approve.model.vo.Approve;
import kr.or.erp.approve.model.vo.Document;
import kr.or.erp.notice.model.vo.Notice;


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
		
		Document type = approveService.typeContent(doc);
				
		return type;
	}
	
	//결재대기 목록
	@ResponseBody
	@GetMapping(value="/dotype", produces = "application/json;charset=UTF-8")
	public Approve dotype(Approve ap) {
		
		Approve apType = approveService.typeDocument(ap);
		
				
		return apType;
	}
	
	@ResponseBody
	@PostMapping(value="/insert", produces = "text/html;charset=UTF-8")
	public String insert(Approve a) {
		int result = approveService.insertDocument(a);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
		
	}
	
	//결재 목록으로 이동
	@GetMapping("/list")
	 public String docList(Model model) {
        ArrayList<Document> list = approveService.docList(); 
        
        model.addAttribute("docList", list);

        return "approve/document"; 
    }
	
	@ResponseBody
	@PostMapping(value="/update", produces = "text/html;charset=UTF-8")
	public String updateStatus(Approve a) {
		
		
		int result = approveService.updateStatus(a);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
		
	}
	
	@ResponseBody
	@PostMapping(value="/refuse", produces = "text/html;charset=UTF-8")
	public String refuseStatus(Approve a) {
		
		
		int result = approveService.refuseStatus(a);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
		
	}
	
	
	@ResponseBody
	@PostMapping(value="/wait", produces = "text/html;charset=UTF-8")
	public String waitStatus(Approve a) {
		
		
		int result = approveService.waitStatus(a);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
		
	}
	
	
	
}
