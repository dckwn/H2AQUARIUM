package member;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;


public class FileUtil {
	private static FileUtil instance = new FileUtil();
	public static FileUtil getInstance() {
		return instance;
	}
	private FileUtil() {
		File dir = new File(saveDirectory);
		dir.mkdirs();
	}
	
	private String saveDirectory = "D:\\KG\\10월 오전취업반_이동훈\\JSP\\upload\\profile";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding = "UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	public MemberDTO getDTO(HttpServletRequest request) throws Exception{
		MemberDTO dto = null;
		
		MultipartRequest mpRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		System.out.println(mpRequest.getParameter("idx") + " " +mpRequest.getParameter("email") );
		dto = new MemberDTO();
		
		File uploadFile = mpRequest.getFile("profile_image");
		if(uploadFile != null) {
			dto.setProfile_image(uploadFile.getName());
		}
		if(mpRequest.getParameter("idx") != null) {
			int idx = Integer.parseInt(mpRequest.getParameter("idx"));
			dto.setIdx(idx);
		};
		dto.setEmail(mpRequest.getParameter("email"));
		dto.setUsername(mpRequest.getParameter("username"));
		if(mpRequest.getParameter("gender")!=null)dto.setGender(mpRequest.getParameter("gender"));
		if(mpRequest.getParameter("userid")!=null)dto.setUserid(mpRequest.getParameter("userid"));
		if(mpRequest.getParameter("userpw")!=null)dto.setUserpw(mpRequest.getParameter("userpw"));
		
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
