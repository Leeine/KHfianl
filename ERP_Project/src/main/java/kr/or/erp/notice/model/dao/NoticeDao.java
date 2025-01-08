package kr.or.erp.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.notice.model.vo.Notice;

@Component
public class NoticeDao {

	public int noticeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.noticeListCount");
	}

	public ArrayList<Notice> noticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("noticeMapper.noticeList",null,rowBounds);
	}

	public Notice noticeDetail(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.selectOne("noticeMapper.noticeDetail",n);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("noticeMapper.increaseCount",n);
	}

	public ArrayList<Notice> index(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("noticeMapper.index");
	}

	public int insert(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insert",n);
	}

}
