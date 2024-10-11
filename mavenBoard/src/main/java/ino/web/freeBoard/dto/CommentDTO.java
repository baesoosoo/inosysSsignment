package ino.web.freeBoard.dto;

public class CommentDTO {
	
	int num;  //댓글 글번호
	String writer; //댓글 작성자의 아이디
	String content; //댓글 내용
	int ref_group;  //원글의 글번호
	int comment_group; //댓글의 그룹번호
	String deleted;	//삭제된 댓글인지 여부
	String regdate;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRef_group() {
		return ref_group;
	}
	public void setRef_group(int ref_group) {
		this.ref_group = ref_group;
	}
	public int getComment_group() {
		return comment_group;
	}
	public void setComment_group(int comment_group) {
		this.comment_group = comment_group;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "CommentDTO [num=" + num + ", writer=" + writer + ", content=" + content + ", target_id=" 
				+ ", ref_group=" + ref_group + ", comment_group=" + comment_group + ", deleted=" + deleted
				+ ", regdate=" + regdate + "]";
	}
	
}
