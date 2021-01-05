package member;

import java.util.Date;

public class MemberVO {

	private int memno;
	private String name;
	private String id;
	private String pass;
	private int birth;
	private String gender;
	private String job;
	private String city;
	//joindate는 Date로 받아준다.
	private Date  joindate;
	
	
	public MemberVO(int  memno, String name,String id,String pass, int birth, String gender, String job, String city, Date joindate) {
		this.memno = memno;
		this.name = name;
		this.id = id;
		this.pass = pass;
		this.birth = birth;
		this.gender = gender;
		this.job = job;
		this.city = city;
		this.joindate = joindate;
	}
	
	public MemberVO() {}

	
	public int getMemno() {
		return memno;
	}

	public void setMemno(int memno) {
		this.memno = memno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

	@Override
	public String toString() {
		return "MemberVO [memno=" + memno + ", name=" + name + ", id=" + id + ", pass=" + pass + ", birth=" + birth
				+ ", gender=" + gender + ", job=" + job + ", city=" + city + ", joindate=" + joindate + "]";
	}
	
	
}
