package showtable;

public class ShowDTO {
	private int show_id;
	private String show_name;
	private String show_img;
	private String show_content;
	
	public String getShow_img() {
		return show_img;
	}
	public void setShow_img(String show_img) {
		this.show_img = show_img;
	}
	public String getShow_content() {
		return show_content;
	}
	public void setShow_content(String show_content) {
		this.show_content = show_content;
	}
	public int getShow_id() {
		return show_id;
	}
	public void setShow_id(int show_id) {
		this.show_id = show_id;
	}
	public String getShow_name() {
		return show_name;
	}
	public void setShow_name(String show_name) {
		this.show_name = show_name;
	}

}
