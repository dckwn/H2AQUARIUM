package datey;


public class Cal {
	private int month;
	private int startDayOfWeek;
	private int lastDay;
	private String yoil;
	
	public String getYoil(int month) {
		switch(month) {
		case 1: yoil ="January"; break;
		case 2: yoil ="February";break;
		case 3: yoil ="March";break;
		case 4: yoil ="April";break;
		case 5: yoil ="May";break;
		case 6: yoil ="June";break;
		case 7: yoil ="July";break;
		case 8: yoil ="August";break;
		case 9: yoil ="September";break;
		case 10: yoil ="October";break;
		case 11: yoil ="November";break;
		case 12: yoil ="December";
		}
		return yoil;
	}

	public void setYoil(String yoil) {
		this.yoil = yoil;
	}

	public static Cal newInstance(int month) {
		return new Cal(month); 
	}
	
	private Cal(int month) {
		
		this.month = month;
		java.util.Calendar cal = new java.util.GregorianCalendar(2024, month-1, 1);
		startDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
		lastDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);		
	}
	
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getStartDayOfWeek() {
		return startDayOfWeek;
	}
	public void setStartDayOfWeek(int startDayOfWeek) {
		this.startDayOfWeek = startDayOfWeek;
	}
	public int getLastDay() {
		return lastDay;
	}
	public void setLastDay(int lastDay) {
		this.lastDay = lastDay;
	}
	
}
