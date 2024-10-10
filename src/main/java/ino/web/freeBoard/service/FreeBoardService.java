package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.CommentDTO;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.dto.Pagination;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FreeBoardDto> freeBoardList(int page,int pageSize){
		
		Map<String, Object> search = new HashMap<>();
		    
		    search.put("page", page);
		    search.put("pageSize", pageSize);
		    search.put("offset", (page - 1) * pageSize); 
		
		return sqlSessionTemplate.selectList("freeBoardGetList",search);
	}
	
	
	public List<FreeBoardDto> freeBoardList(String inputCont, String selectedOption, int currentPage, int pageSize) {
		
	    Map<String, Object> search = new HashMap<>();
	    
	    search.put("inputCont", inputCont);
	    search.put("selectedOption", selectedOption);
	    search.put("offset", (currentPage - 1) * pageSize); 
	    search.put("pageSize", pageSize);
	    
	    System.out.println("서비스 내용 >>> " + search);
	    
	    if ("6".equals(selectedOption) && inputCont != null && inputCont.contains("-")) {
	        String[] dates = inputCont.split("-");
	        
	        if (dates.length == 2) {
	            search.put("date1", dates[0].trim());
	            search.put("date2", dates[1].trim());
	        }
	        System.out.println("search 날짜 >>> " + inputCont);
	    }

	    List<FreeBoardDto> list = sqlSessionTemplate.selectList("freeBoardSearch", search);
	    System.out.println("list >>>> " + list);
	    
	    return list;
	}

	


	public void freeBoardInsertPro(FreeBoardDto dto){
		
		Integer maxNum = sqlSessionTemplate.selectOne("freeBoardNewNum");
		
		System.out.println("maxNum>>>>>>>"+maxNum);
		
		if(maxNum != null) {
			dto.setNum(maxNum+1);;
		}else {
			dto.setNum(1);
		}
		sqlSessionTemplate.insert("freeBoardInsertPro",dto);
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public void freeBoardModify(FreeBoardDto dto){
		sqlSessionTemplate.update("freeBoardModify", dto);
	}

	public void FreeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);

	}
	
	public void FreeBoardDeleteAll (List<Long> num) {
		sqlSessionTemplate.delete("freeBoardDeleteAll", num);
	}

	//댓글 추가
	public void addComment(CommentDTO comment) {
		
		Integer commentcn = sqlSessionTemplate.selectOne("commentCn");

		if(commentcn != null) {
			comment.setNum(commentcn+1);
		}else {
			comment.setNum(1);
		}
		
		System.out.println("서비스에서 댓글>>>"+comment);
		
		sqlSessionTemplate.insert("addCommetn", comment);
		
	}
	//댓글 불러오기
	public List<CommentDTO> getCommentList(int num){
		
		List<CommentDTO>CommentList = sqlSessionTemplate.selectList("getCommentList", num);
		
		return CommentList;
		
	}
	
	//댓글 수정
	public void commentModify(String content,int num) {
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("content", content);
		response.put("num", num);
		
		sqlSessionTemplate.update("commentModify", response);
		
	}
}
