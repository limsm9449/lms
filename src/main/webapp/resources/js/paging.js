function f_makePageNavigator(objId, currentPage, totalCount, pageBlock) {
	var pagingHTML = "";
 
	var navigatorNum    = 10;

	var firstPageNum  = 1;
	var lastPageNum = (pageBlock == 1 ? totalCount : parseInt((totalCount-1)/pageBlock) + 1);
	var previewPageNum = (currentPage == 1 ? 1 : currentPage - 1);
	var nextPageNum = (currentPage == lastPageNum ? lastPageNum : currentPage + 1);

	var indexNum = (currentPage <= navigatorNum  ? 0 : parseInt((currentPage-1)/navigatorNum) * navigatorNum);
  
	/*
	pagingHTML += "<a class='btn_first disabled' href='javascript:paging("+firstPageNum+");'>" + pprev + "</a> ";
	pagingHTML += "<a class='btn_prev disabled' href='javascript:paging("+previewPageNum+");'>" + prev + "</a> ";
	for (var i = 1; i <= navigatorNum; i++) {
		var pageNum = i + indexNum;
		if ( pageNum == currentPage ) 
			pagingHTML += "<a class='selected' href='javascript:paging("+pageNum+");'><b>"+pageNum+"</b></a> ";
		else 
			pagingHTML += "<a href='javascript:paging("+pageNum+");'>"+pageNum+"</a>  ";
		
		if ( pageNum == lastPageNum )
			break;
	}
	pagingHTML += "<a class='btn_next' href='javascript:paging("+nextPageNum+");'>" + next + "</a> ";
	pagingHTML += "<a class='btn_end' href='javascript:paging("+lastPageNum+");'>" + nnext + "</a>";
	pagingHTML += "<input id='pageNum' name='pageNum' value='" + currentPage + "' type='hidden'/>";
	*/
	
	pagingHTML += "<div class='navi'>";
	pagingHTML += "	<ul class='back'>";
	pagingHTML += "		<li class='first'><a href='#' onclick='javascript:paging("+firstPageNum+");'><img src='/resources/images/admin/common/btn_first.png' /></a></li>";
	pagingHTML += "		<li class='prev'><a href='#' onclick='javascript:paging("+previewPageNum+");'><img src='/resources/images/admin/common/btn_prev.png' /></a></li>";
	pagingHTML += "	</ul>";
	pagingHTML += "	<ul class='page'>";
	for (var i = 1; i <= navigatorNum; i++) {
		var pageNum = i + indexNum;
		if ( pageNum == currentPage ) 
			pagingHTML += "		<li class='here'>"+pageNum+"</li>";
		else 
			pagingHTML += "		<li><a href='#' onclick='javascript:paging("+pageNum+");'>"+pageNum+"</a></li>";
		
		if ( pageNum == lastPageNum )
			break;
	}
	pagingHTML += "	</ul>";
	pagingHTML += "	<ul class='forward'>";
	pagingHTML += "		<li class='next'><a href='#' onclick='javascript:paging("+nextPageNum+");'><img src='/resources/images/admin/common/btn_next.png' /></a></li>";
	pagingHTML += "		<li class='last'><a href='#' onclick='javascript:paging("+lastPageNum+");'><img src='/resources/images/admin/common/btn_end.png' /></a></li>";
	pagingHTML += "	</ul>";
	pagingHTML += "</div>";
	pagingHTML += "<input id='pageNum' name='pageNum' value='" + currentPage + "' type='hidden'/>";

	
	$("#"+objId).html(pagingHTML);
}

/**
 * 페이징 검색
 * @param pPage
 */
function paging(pPage) {
	lfn_btn("paging", {page:pPage});
}	 
