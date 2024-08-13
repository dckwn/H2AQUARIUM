package alarm;

//IDX      NOT NULL NUMBER        
//FISH_IDX          NUMBER        
//USERID   NOT NULL VARCHAR2(100) 
public class AlarmDTO {
	private int idx;
	private int fish_idx;
	private String userid;
	
	public AlarmDTO() {
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFish_idx() {
		return fish_idx;
	}

	public void setFish_idx(int fish_idx) {
		this.fish_idx = fish_idx;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	

}
