package reservation;

public class ReserveDTO {
	private int idx;
	private int date_id;
	private int show_id;
	private int time_id;
	private int seat_id;
	private int user_id;
	private int seat[];
	
	public int[] getSeat() {
		return seat;
	}
	public void setSeat(int[] seat) {
		this.seat = seat;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getDate_id() {
		return date_id;
	}
	public void setDate_id(int date_id) {
		this.date_id = date_id;
	}
	
	public int getShow_id() {
		return show_id;
	}
	public void setShow_id(int show_id) {
		this.show_id = show_id;
	}
	public int getTime_id() {
		return time_id;
	}
	public void setTime_id(int time_id) {
		this.time_id = time_id;
	}
	public int getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}
}
