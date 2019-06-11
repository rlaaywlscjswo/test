package com.bitcamp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.bitcamp.dto.BoardDTO;

public class BoardDAO {//싱글톤패턴
	private BoardDAO() {
	}

	private static BoardDAO instance = new BoardDAO(); // 객체 갖다쓸라공/

	public static BoardDAO getInstance() {
		return instance;
	}

	private Connection getConnection() {
		Connection conn = null;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/bitcamp");
			conn = ds.getConnection();
		} catch (NamingException | SQLException e) {
			System.out.println(e);
		}
		return conn;
	} // jdbc로...연결메소드

	public int insertList(BoardDTO dto) {
		StringBuilder sql = new StringBuilder();
		sql.append(" insert into                                     ");
		sql.append(" m1board values                                  ");
		sql.append("  (  m1seq.nextval , ? , ? , ? , sysdate , 0  )  ");
		int result = 0;
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, dto.getTbltitle());
			pstmt.setString(2, dto.getTblcontent());
			pstmt.setString(3, dto.getTblwriter());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		}
		return result;
	}
	
	public List<BoardDTO> searchList(String search, String searchtxt) {
		StringBuilder sql = new StringBuilder();
		sql.append("  select no       ");
		sql.append("        ,title    ");
		sql.append("        ,content  ");
		sql.append("        ,writer   ");
		sql.append("        ,writedate ");
		sql.append("        ,viewcnt   ");
		sql.append("   from m1board    ");
	

		if(!("".equals(search))&& !("".equals(searchtxt))) {
			if("title".equals(search))
				sql.append(" where title like ?   ");
			else if("content".equals(search))
				sql.append(" where content like ?  ");
			else if("writer".equals(search))
				sql.append("where writer like ?    ");
		}
		sql.append(" order by no desc  ");
		List<BoardDTO> arr = new ArrayList<BoardDTO>();
		ResultSet rs=null;
		try(Connection conn=getConnection();
			PreparedStatement pstmt=conn.prepareStatement(sql.toString());	){
			if(!("".equals(search))&&!("".equals(searchtxt)))
				pstmt.setString(1, "%"+searchtxt+"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto=new BoardDTO();
				dto.setTblno(rs.getInt("no"));
				dto.setTbltitle(rs.getString("title"));
				dto.setTblcontent(rs.getString("content"));
				dto.setTblwriter(rs.getString("writer"));
				dto.setTblwritedate(rs.getString("writedate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				arr.add(dto);
				}			
		}catch(SQLException e) {
			System.out.println(e);
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch(SQLException e) {
					System.out.println(e);
				}
			}
		}
		return arr;		
	}
	public int modiList(BoardDTO dto) {
		StringBuilder sql = new StringBuilder();
		sql.append(" update  m1board                 ");
		sql.append(" set                             ");
		sql.append("     title = ?  , content=  ?    ");
		sql.append(" where no = ?                    ");
		int result = 0;
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setString(1, dto.getTbltitle());
			pstmt.setString(2, dto.getTblcontent());
			pstmt.setInt(3, dto.getTblno());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		}
		return result;

	}

	public void viewCount(int no) {
		StringBuilder sql = new StringBuilder();
		sql.append(" update m1board                 ");
		sql.append(" set viewcnt=nvl(viewcnt,0)+1   ");
		sql.append("  where  no=  ?                 ");
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		}

	}

	public BoardDTO detailList(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		sql.append(" select no         ");
		sql.append("        ,title     ");
		sql.append("        ,content   ");
		sql.append("        ,writer    ");
		sql.append("        ,writedate ");
		sql.append("        ,viewcnt   ");
		sql.append(" from m1board      ");
		sql.append(" where no= ?       ");
		BoardDTO dto = new BoardDTO();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setTblno(rs.getInt("no"));
				dto.setTbltitle(rs.getString("title"));
				dto.setTblcontent(rs.getString("content"));
				dto.setTblwriter(rs.getString("writer"));
				dto.setTblwritedate(rs.getString("writedate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
		}
		return dto;
	}

	public int delList(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		sql.append(" delete from m1board       ");
		sql.append(" where no  =    ?          ");
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
		}
		return result;
	}

	public List<BoardDTO> getList() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select no         ");
		sql.append("        ,title     ");
		sql.append("        ,writer    ");
		sql.append("        ,writedate ");
		sql.append("        ,viewcnt   ");
		sql.append(" from m1board      ");
		
		List<BoardDTO> arr = new ArrayList<BoardDTO>();
		ResultSet rs = null;
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setTblno(rs.getInt("no"));
				dto.setTbltitle(rs.getString("title"));
				dto.setTblwriter(rs.getString("writer"));
				dto.setTblwritedate(rs.getString("writedate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				arr.add(dto);
			}
		} catch (SQLException e) {
			System.out.println(e);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.out.println(e);
				}
			}
		}
		return arr;
	}
}
