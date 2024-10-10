package ino.web.freeBoard.controller;


import ino.web.freeBoard.dto.CommentDTO;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.dto.Pagination;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(@RequestParam(defaultValue = "1") int page, 
	        @RequestParam(defaultValue = "5") int pageSize) {

	    int totalCount = freeBoardService.getNewNum();
	    System.out.println("total값>>>>" + totalCount);
	    
	    Pagination pagination = new Pagination(totalCount, page, pageSize);
	    
	    List<FreeBoardDto> list = freeBoardService.freeBoardList(page, pageSize);
	    
	    System.out.println("list>>>>" + list);
	    
	    ModelAndView mv = new ModelAndView("boardMain");
	    mv.addObject("list", list);
	    mv.addObject("pagination", pagination);
	    
	    return mv;
	}

	
// 날짜검색시 값을 더해주거나 붙이지 않는다. ajax , FreeBoardService는 수정으로 쓰기 새로 만들지x
	
	@RequestMapping(value = "/mainSearch.ino", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mainSearch(@RequestBody Map<String, Object> requestBody) {
		
	    String inputCont = (String) requestBody.get("inputCont");
	    String selectedOption = (String) requestBody.get("selectedOption");
	    int currentPage = (int) requestBody.get("page");
	    int pageSize = (int) requestBody.get("pageSize");

	    System.out.println("내용>>> " + inputCont);
	    System.out.println("선택 값>>> " + selectedOption);
	    
	    List<FreeBoardDto> searchList = freeBoardService.freeBoardList(inputCont, selectedOption, currentPage, pageSize);

	    System.out.println("검색 후 출력 데이터 >>>" + searchList);

	    Map<String, Object> response = new HashMap<>();

	    try {
	        response.put("success", true);
	        response.put("searchList", searchList);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }

	    return response;
	}

	
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}
	

	@RequestMapping(value = "/freeBoardInsertPro.ino", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, @ModelAttribute FreeBoardDto dto) {
	
		Map<String, Object> response = new  HashMap<>();
		
		int num;
		
		try {
			
	    System.out.println("dto>>>>>>" + dto);
	    freeBoardService.freeBoardInsertPro(dto);
	    
	     num = dto.getNum();
	     
	     response.put("success", true);
	     response.put("num", num);
	    
		}catch(Exception e){
		
		response.put("success", false);
		response.put("message", e.getMessage());
			
		}
		return response;
		
	}


	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,@RequestParam("num") int num){
		
		System.out.println("num>>>"+num);
		FreeBoardDto freeBoardDto = freeBoardService.getDetailByNum(num);
		
		List<CommentDTO> commentList = freeBoardService.getCommentList(num);
		
		System.out.println("freeBoardDto>>>"+freeBoardDto);
		
		  ModelAndView mav = new ModelAndView("freeBoardDetail");
		    mav.addObject("freeBoardDto", freeBoardDto);
		    mav.addObject("commentList", commentList); 
		    
		    return mav;
	}

	@RequestMapping(value="/freeBoardModify.ino",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> freeBoardModify(HttpServletRequest request,@ModelAttribute FreeBoardDto dto){
		
		System.out.println("수정>>>>>>" + dto);
		
		Map<String, Object> response = new  HashMap<>();
		
		try {
			
			freeBoardService.freeBoardModify(dto);
			response.put("success", true);
			response.put("dto", dto);
			
		}catch(Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		
		
		return response;
	}


	@RequestMapping(value="/freeBoardDelete.ino", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> freeBoardDelete(int num){
		
		Map<String, Object> response = new  HashMap<>();
		
		try {
			
			freeBoardService.FreeBoardDelete(num);
			response.put("success", true);
			response.put("num", num);
			
		}catch(Exception e){
			
			response.put("success", false);
			response.put("message", e.getMessage());
				
		}
		
		return response;
	}
	
	@RequestMapping(value= "/freeBoardDeleteAll.ino", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> freeBoardDeleteAll(@RequestBody List<Long> paramList) {
	    System.out.println("선택 리스트>>>" + paramList);
	    
	    Map<String, Object> response = new  HashMap<>();
	    
	    try {
	    	freeBoardService.FreeBoardDeleteAll(paramList);
	    	response.put("success", true);
			response.put("paramList", paramList);
	    	
	    }catch(Exception e) {
	    	
	    	response.put("success", false);
			response.put("message", e.getMessage());
	    }
	    
	    return response;
	}
	
	//댓글 작성
	@RequestMapping(value="/add.ino",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addComment(@ModelAttribute CommentDTO comment){
		
		int num= comment.getRef_group();
		comment.setRef_group(num);
		System.out.println("comment>>>>>"+comment);
		
		Map<String, Object> add = new HashMap<>();
		
		try {
			
			 freeBoardService.addComment(comment);
			 add.put("success", true);
			
		}catch (Exception e) {
			
			add.put("success", false);
			add.put("message", e.getMessage());
			
		}
		return add;
	}
	

	
	  
	  

	
}