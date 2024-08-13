package board;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class FileUtilList {
	private static FileUtilList instance = new FileUtilList();
	public static FileUtilList getInstance () {
		return instance;
	}
	private FileUtilList() {
		File dir = new File(saveDirectory);
		dir.mkdirs();
	}
	
	private String saveDirectory = "D:\\KG\\10월 오전취업반_이동훈\\JSP\\upload\\fish";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding = "UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	public BoardDTO getDTO(HttpServletRequest request) throws Exception {
		BoardDTO dto = null;
		
		MultipartRequest mpRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		dto = new BoardDTO();
		
		File uploadFile = mpRequest.getFile("image");
		if(uploadFile != null) {
			dto.setImage(uploadFile.getName());
		}
		if(mpRequest.getParameter("idx") != null) {
			int idx = Integer.parseInt(mpRequest.getParameter("idx"));
			dto.setIdx(idx);
		};
		dto.setName(mpRequest.getParameter("name"));
		dto.setCategory(mpRequest.getParameter("category"));
		dto.setPlace(mpRequest.getParameter("place"));
		dto.setContent(mpRequest.getParameter("content"));
		
		return dto;
	}
	
	public boolean deleteImageFile(String imageName) {
		boolean check = false;
		File f = new File(saveDirectory, imageName);
		
		if(f.exists()) {
			if(f.delete()) {check=true;}
		}
		return check;		
	}
		
}
