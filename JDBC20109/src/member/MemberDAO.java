package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {
	//DAO : 기능 구현클래스
	private static MemberDAO instance = new MemberDAO();
	
	private MemberDAO() {}
	
	public static MemberDAO getInstance() {
		return instance;
	}
	// ArrayList<MemberVO> list ==> 여러 row 이루어진 결국 -> 데이터베이스에 테이블로 구성
	private static ArrayList<MemberVO> list = new ArrayList<MemberVO>();
	
	//2 : 오라클(또는 mysql)커넥션 객체생성
	//drive
	public Connection getConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user = "hr";
		String password = "hr";
		Connection conn = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("오라클접속 성공");
		}catch (Exception e) {
			System.out.println("오라클접속 실패");
			e.printStackTrace();
		}
		return conn;
	}
	// DB객체, 초기화
	Connection conn = null; 
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//3 : 회원번호를 1씩 증가시키기 위한 테이블의 memno의 최댓값 리턴
	public int getMaxNo() {
		int memno = 0; 

		try {
			//커넥션
			conn = instance.getConnection(); // 오라클
			//최댓값 구하는 sql문 max(memno)로 memno의 최댓값 찾아준다
			String sql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
			//sql실행
			pstmt = conn.prepareStatement(sql);
			//결과문
			rs = pstmt.executeQuery();
			//회원번호에 1 증가시켜줌
			if (rs.next()) {
				memno = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			System.out.print("getMaxNo() 오류");
			e.printStackTrace();
		} finally {
			//객체반환
			close(rs,  pstmt, conn);
		}
		return memno;
	}
	
	//4 : selectSql 실행 전체 목록
	public ArrayList<MemberVO> selectMembers(){
		ArrayList<MemberVO> memberlist  = new ArrayList<MemberVO>();
	
		try {
			// 오라클 연동하는 객체들
			//conn = instance.getConnection(); // 오라클
			String sql = "select * from MEMBER_TBL"; // sql쿼리스트링
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// rs.next row 한줄을 가져온다
				MemberVO member = new MemberVO();
				// student.setStuNo(rs.getInt(1)); 컬럼 순서
				member.setMemno(rs.getInt("memno")); // 컬럼 이름으로 값 가져오기
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setBirth(rs.getInt("birth"));
				member.setGender(rs.getString("gender"));
				member.setJob(rs.getString("job"));
				member.setCity(rs.getString("city"));
				member.setJoindate(rs.getDate("joindate"));
				memberlist.add(member);
			}
			System.out.println("회원 출력 완료");

		} catch (Exception e) {
			// try안에 있는 코드의 오류를 잡아서
			System.out.println("getMemberList() 오류");
			e.printStackTrace(); // 콘솔창에 에러 출력
		} finally {
			//객체반환
			close(rs,  pstmt, conn);
		}
		
		return memberlist;
	}
	
	//5 :  insertSql 실행 - 성공시 row 개수 리턴
	// insertStudent : 외부 form input 받아온것을 오라클에 넣어주면 기능만 하면돼
		// 리턴이 굳이 필요하지 않지만 boolean 리턴을 해준다 => insert 테이블에 성공적으로 삽입 : true
	public boolean insertMember(MemberVO vo) {
		int memno = getMaxNo();
		
		try {
			//오라클이랑 연결해준다
			conn = instance.getConnection();
			//insert쿼리문을 작성해 실행시킨다
			String insertsql = "INSERT INTO MEMBER_TBL(memno, name, id, pass, birth, gender, job, city, joindate) VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			
			pstmt = conn.prepareStatement(insertsql);
			//테이블에 있는 값
			pstmt.setInt(1, memno);
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getId());
			pstmt.setString(4, vo.getPass());
			pstmt.setInt(5, vo.getBirth());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getJob());
			pstmt.setString(8, vo.getCity());
			//회원추가 해주기
			pstmt.executeUpdate();
			System.out.println("회원추가 완료");
			return true;
		} catch (Exception e) {
			System.out.println("insertMember() 오류");
			e.printStackTrace(); // 콘솔창에 에러 출력
		} finally {
			//객체반환
			close(null,  pstmt, conn);
		}
		return false;
	}
	//6 : updateSql 실행 - 성공시 row 개수 리턴
	public int updateMember(MemberVO vo) {
		try {
			conn = instance.getConnection(); //오라클연동
			//회원정보를 수정해주기위해 쿼리문을 가져온다
			//updatsql구현
			String sql = "UPDATE MEMBER_TBL SET PASS=?, BIRTH=?, GENDER=?, JOB=?, CITY=? WHERE MEMNO=?";
			int cnt = 0;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPass());
			pstmt.setInt(2, vo.getBirth());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getJob());
			pstmt.setString(5, vo.getCity());
			pstmt.setInt(6, vo.getMemno());
			cnt = pstmt.executeUpdate();
			System.out.println("회원수정 완료");
			return cnt;

		} catch (Exception e) {
			System.out.println("getMemberList() 오류");
			e.printStackTrace(); // 콘솔창에 에러 출력
		} finally {
			//객체반환
			close(null, pstmt, conn);
		}
		return 0;
	}
	
	//7 : deleteSql 실행 - 성공시 row 개수 리턴
	public int deleteMember(MemberVO vo) {
		try {
			 //연결객체
			Connection conn = instance.getConnection();

			//셀렉트 실행하는 쿼리문
			String selectSql = "SELECT ID, PASS FROM MEMBER_TBL WHERE MEMNO = ?";
			//딜리트 실행하는 쿼리문
			String deleteSql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?";
			int cnt = 0;
			//동적할당 pstmt객체
			PreparedStatement pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, vo.getMemno());
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String dbPass = rs.getString("pass");
				//저장된 비밀번호와 입력한 비밀번호가 다른지 체크
				if (vo.getPass().equals(dbPass)) {
					//딜리트쿼리문 실행
					pstmt = conn.prepareStatement(deleteSql);
					pstmt.setInt(1, vo.getMemno());
					cnt = pstmt.executeUpdate();
					return cnt;
				}
			}
		} catch (Exception e) {
			System.out.println("getMemberList() 오류");
			e.printStackTrace(); // 콘솔창에 에러 출력
		}
		return 0;
	}
	
	//8 : selectSql(memno에 해당하는 자료 1건
	public MemberVO getAMember(int memno) {
		MemberVO member = new MemberVO();
		try {
			conn = instance.getConnection(); // 오라클 연동
			//테이블에서 memno에 해당하는 자료 하나 가져오는 쿼리문
			String sql = "select * from MEMBER_TBL where memno = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member.setMemno(rs.getInt("memno")); // 컬럼 이름으로 값 가져오기
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setBirth(rs.getInt("birth"));
				member.setGender(rs.getString("gender"));
				member.setJob(rs.getString("job"));
				member.setCity(rs.getString("city"));
				member.setJoindate(rs.getDate("joindate"));
				
				return member;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//객체반환
			close(rs, pstmt, conn);
		}
		return member;
	}
	
	//9 : jdbc 활용한 객체들 역순으로 자원반환
	//conn객체, preparedStatement객체, resultset객체를 생성했으니
	//나중에 생성한 객체부터 close해준다.
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
	
	//10.public boolean idAvailableChk(String id) - idCheck.jsp의 checkSql실행
	public boolean idAvailableChk(String id) {
		try {
			//오라클 연동
			conn = instance.getConnection(); //conn객체 생성
			//체크할 id 가져옴
			String chksql ="select*from member_tbl where id =?";
			boolean result = false;
			pstmt = conn.prepareStatement(chksql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			//아이디가 중복되는지 id.Check 랑 확인
			if (!rs.next()) {
				result = true;
			}
			return result;
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			//객체반환
			close(rs,  pstmt, conn);
		}
		
		return false;
		
	}
}