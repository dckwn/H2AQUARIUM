package datey;

import java.sql.Date;

public class DateDTO {
	private int date_id;
	private Date resDate;
	
	public int getDate_id() {
		return date_id;
	}
	public void setDate_id(int date_id) {
		this.date_id = date_id;
	}
	public Date getResDate() {
		return resDate;
	}
	public void setResDate(Date resDate) {
		this.resDate = resDate;
	}
}
