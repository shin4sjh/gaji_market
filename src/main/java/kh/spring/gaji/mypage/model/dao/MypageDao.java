package kh.spring.gaji.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.spring.gaji.mypage.model.dto.MypageDto;

@Repository
public class MypageDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	public List<MypageDto> userMypage(String userId){
		return sqlSession.selectList("mypage.userMypage",userId);
	}
	
	public int updateName(Map<String, String> map) {
		return sqlSession.update("mypage.updateName",map);
	}
	
	public int updateNickname(Map<String, String> map) {
		return sqlSession.update("mypage.updateNickname",map);
	}
	
	public int updateEmail(Map<String, String> map) {
		return sqlSession.update("mypage.updateEmail",map);
	}
	
	public int updateMobileNumber(Map<String, String> map) {
		return sqlSession.update("mypage.updateMobileNumber",map);
	}
	
	public String checkName(String name) {
		return sqlSession.selectOne("mypage.checkName", name);
	}
	
	public String checkNickname(String nickname) {
		return sqlSession.selectOne("mypage.checkNickname", nickname);
	}
	
	public String checkEmail(String email) {
		return sqlSession.selectOne("mypage.checkEmail", email);
	}
	
	public String checkMobilNumber(String mobileNumber) {
		return sqlSession.selectOne("mypage.checkMobilNumber", mobileNumber);
	}
}
