package com.popup.project.board.promotion.dto;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
 
/*
Controller와 Mybatis Mapper 사이에서 매개역할을 하는 인터페이스로
어노테이션은 @Mapper를 부착한다. 
컨트롤러는 인터페이스의 추상메서드를 호출하고, 이를 통해 Mapper의 특정 엘리먼트가
동작되는 방식으로 구성된다. 
 */
@Mapper
public interface IBoardService {
	//목록 : 게시물의 갯수를 카운트(커맨드 객체 사용) 
	public int getTotalCount(ParameterDTO parameterDTO);
	//목록 : 한페이지에 출력할 게시물을 인출(커맨드 객체 사용) 
	public ArrayList<SimpleBbsDTO> listPage(ParameterDTO parameterDTO);
	//글작성
	public int write(SimpleBbsDTO dto);
					
	//내용보기(커맨드 객체 사용)
	public SimpleBbsDTO view(SimpleBbsDTO simplebbsDTO);
	//수정(커맨드 객체 사용)
	public int edit(SimpleBbsDTO simplebbsDTO);
	//삭제
	public int promotionDelete(String promotion_num);
	//조회수
	void incrementVisitCount(String promotion_num);
	//다운로드수
	void incrementDownCount(String promotion_num);
	
}

