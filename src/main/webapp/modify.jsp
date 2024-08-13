<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>

	.write_flex {
		display: flex;
		margin-bottom: 5px;
	}
	
	.write_flex > select {
		width: 100px;
		height: 32px;
		border: 0.5px solid gray;
	}
	
	.write_flex > input {
		width: 1000px;
		height: 30px;
		border: 0.5px solid gray;
	}
	
	.wit {
		background-color: white;
		height: fit-content;
	}
	
	.write > input:nth-child(3) {
		width: 984px;
		height: 30px;
		font-size: 15px;
		margin-bottom: 10px;
	}
	
	.write > select {
		width: 100px;
		height: 30px;
		font-size: 15px;
	}
	
	.bwt {
		display: flex;
		justify-content: space-between;
	}
	
	.bwt > input:nth-child(2) {
		width: 100px;
		height: 30px;
		font-size: 15px;
		margin: 10px;
	}
</style>

<c:if test="${login.userid != 'admin'}">
	<script>
		alert('잘못된 접근 입니다')
		history.go(-1)	
	</script>
</c:if>

<c:if test="${login.userid == 'admin'}">
	<div class="main-img">
		<h2>FISHLIST수정</h2>
	</div>
	<c:if test="${pageContext.request.method == 'GET' }">
		<div class="frame wit">
			<c:set var="dto" value="${boardDAO.selectOne(param.idx) }" />
			<form class="write" action="" method="POST" enctype="multipart/form-data">
				<div class="write_flex">
					<select name="category">
						<option value="해수어">해수어</option>
						<option value="담수어">담수어</option>
					</select>
					<select name="place">
						<option value="제1 수조">제1 수조</option>
						<option value="제2 수조">제2 수조</option>
						<option value="제3 수조">제3 수조</option>
						<option value="제4 수조">제4 수조</option>
					</select>
					<input type="text" name="name" value="${dto.name }" placeholder="수정하려는 물고기의 이름을 입력" required autofocus>
				</div>
				<textarea name="content" rows="10" cols="170" style="resize: none; width: 1199px;" placeholder="수정하려는 물고기의 관련 설명을 입력">${dto.content }</textarea>
				<div class="bwt">
					<input type="file" name="image" accept="image/*" required>
					<input type="submit" value="수정">
				</div>
			<input type="hidden" name="idx" value="${dto.idx }">
			</form>
		</div>
	</c:if>
	
	<c:if test="${pageContext.request.method == 'POST' }">
		<c:set var="dto" value="${fishfile.getDTO(pageContext.request) }" />
		
		<c:set var="row" value="${boardDAO.modify(dto) }" />

		<c:if test="${row != 0 }">
			<c:set var="filedelete" value="${fishfile.deleteImageFile(param.preImage) }"/>
			
			<script>
				alert('수정되었습니다.')
				location.href = '${cpath }/admin.jsp'
			</script>
		</c:if>
		<c:if test="${row == 0 }">
			<script>
				alert('수정 실패')
				history.go(-1)
			</script>
		</c:if>
	</c:if>
</c:if>
</body>
</html>