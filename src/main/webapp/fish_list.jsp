<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:set var="boardCount" value="${boardDAO.selectCount(param.search, param.category, param.place) }" />
<c:set var="paramPage" value="${empty param.page ? 1 : param.page }" />
<c:set var="paging" value="${Paging.newInstance(paramPage, boardCount) }" />
<c:if test="${empty param.userid }">
	<c:set var="list" value="${boardDAO.selectList(param.search, param.category, param.place, paging) }" />
</c:if>
<c:if test="${not empty param.userid }">
	<c:set var="list" value="${boardDAO.selectLike(param.userid) }" />
</c:if>

<style>
	form.search{
		display:flex;
		align-items:center;
	}
	form.search > select, input {
		height: 60px;
		font-size: 25px;
		border: 0.5px solid #dadada;
		margin: 30px 0;
	}
	form.search > select:nth-child(1) {
		width: 99px;
	}
	form.search > select:nth-child(2) {
		width: 149px;
	}
	form.search > input[type=search] {
		width: 749px;
	}
	form.search > input[type=submit] {
		width: 99px;
		margin-right: 0;
	}
	.search_like {
		 width: 99px;
		 height: 60px;
		 font-size: 25px;
		 border: 0.5px solid #dadada;
		 margin: 30px 0;
		 margin-right: 0;
	}
	.search_pointer {
		cursor: pointer;
	}
	.spam {
		font-size: 30px;
		color: white;
		text-align: center;
	}
	.spamatr {
		font-size: 50px;
		font-weight: bold;
		color: red;
		text-align: center;
	}
	.fish_setting {
		width: 1200px;
		height: fit-content;
		margin: 0px auto;
		display: flex;
		flex-flow: wrap;
	}
	.fish_frame {
		margin: 2px;
		width: 396px;
		height: 250px;
		background-color: white;
	}
	.fish_frame:hover {
	}
	.fish_frame:nth-child(){
		margin: 100px;
	}
	.fish_frame > a > img {
		width: 396px;
		height: 200px;
	}
	.fish_frame > a > span {
		display: flex;
		justify-content: center;
		font-size: 30px;
		color: #406080;
	}
	.relative {
		position: relative;
	}
	.like_count {
		position: absolute;
		left: 370px;
		top: 25px;
		color: white;
		font-size: 20px;
		font-weight: bold
	}
	.paging {
		margin-top: 40px;
	}
	.paging_font {
		font-size: 25px;
	}
</style>

<div class="main-img">
	<h2>FISHLIST</h2>
</div>
<c:if test="${empty param.userid }">
	<div class="frame center">
		<c:if test="${param.place != '' && param.place != null }">
			<span class="spamatr">${param.place }</span>
			<span class="spam"> &nbsp;에 살고 있는</span>
		</c:if>
		<c:if test="${param.category != '' && param.category != null }">
			<span class="spamatr">&nbsp;${param.category } </span>
		</c:if>
		<c:if test="${param.search != '' && param.search != null }">
			<span class="spamatr">&nbsp;"${param.search }"</span>
			<span class="spam">&nbsp;검색 결과</span>
		</c:if>
		<c:if test="${param.search == '' || param.search == null }">
			<span class="spam">&nbsp;물고기 모두 보기</span>
		</c:if>
		<c:if test="${param.place == '' || param.place == null && param.category == '' || param.category == null && param.search == '' || param.search == null}">
			<span class="spam">&nbsp;</span>
		</c:if>
	</div>
</c:if>
<c:if test="${not empty param.userid }">
	<div class="frame center">
		<span class="spamatr">${login.userid }</span>
		<span class="spam">&nbsp;님이 좋아요 표시한 물고기</span>
	</div>
</c:if>


<div class="frame center">
	<form method="GET" class="search">
		<select name="category">
			<option value="">전체</option>
			<option value="해수어">해수어</option>
			<option value="담수어">담수어</option>
		</select>
		<select name="place">
			<option value="">전체</option>
			<option value="제1 수조">제1 수조</option>
			<option value="제2 수조">제2 수조</option>
			<option value="제3 수조">제3 수조</option>
			<option value="제4 수조">제4 수조</option>
		</select>
		<input type="search" name="search" placeholder="물고기의 이름을 검색 합니다">
		<input class="search_pointer" type="submit" value="검색">
	</form>
	<form method="GET">
		<input type="hidden" name="userid" value="${login.userid }">
		<input class="search_pointer search_like" type="submit" value="💘">
	</form>
</div>
<div class="frame">
	<div class="fish_setting">
		<c:forEach var="dto" items="${list }">
			<div class="fish_frame relative">
				<c:set var="fish_like" value="${likeDAO.likeCheck(login.userid, dto.idx) }" />
				<c:set var="likeCount" value="${likeDAO.conutLike(dto.idx) }" />
				<c:if test="${empty login }">
					<img class="like_img" src="image/nolike.png" style="position: absolute; width: 30px; height: 30px; left: 358px; top: 5px; z-index: 5;">
				</c:if>
				<a href="like.jsp?idx=${fish_like.idx }&fish_idx=${dto.idx }">
					<img class="like_img" src="image/like.png" style="position: absolute; width: 30px; height: 30px; left: 358px; top: 5px; ${not empty fish_like ? '' : 'display: none'}">
					<img class="like_img" src="image/nolike.png" style="position: absolute; width: 30px; height: 30px; left: 358px; top: 5px; ${not empty fish_like ? 'display: none' : ''}">
				</a>
				<div class="like_count">${likeCount }</div>
				<a href="${cpath }/view.jsp?idx=${dto.idx }"><img src="${cpath }/fish/${dto.image }"><span>${dto.name }</span></a>
			</div>
		</c:forEach>
	</div>
	
	<c:if test="${empty param.userid }">
		<div class="paging center">
			<c:if test="${paging.prev }">
				<a class="paging_font" href="${cpath }/fish_list.jsp?
					page=${paging.begin - 5 }&category=${param.category }&place=${param.place }&search=${param.search }">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
				<a class="${paging.page == i ? 'bold' : '' } paging_font"
				href="${cpath }/fish_list.jsp?
					page=${i }&category=${param.category }&place=${param.place }&search=${param.search }">[${i }]</a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a class="paging_font" href="${cpath }/fish_list.jsp?
					page=${paging.end + 1 }&category=${param.category }&place=${param.place }&search=${param.search }">[다음]</a>
			</c:if>
		</div>
	</c:if>
</div>

</body>
</html>