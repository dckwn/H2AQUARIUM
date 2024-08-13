package reply;

import java.sql.Date;

public class ReplyDTO {
	private int idx;
	private int fish_idx;
	private String writer;
	private String content;
	private Date writeDate;
	
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
}
