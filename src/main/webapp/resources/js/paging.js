function f_makePageNavigator(objId, currentPage, totalCount, pageBlock, pageCnt) {
	var navigatorNum = pageCnt || 10;

	var firstPageNum  = 1;
	var lastPageNum = (pageBlock == 1 ? totalCount : parseInt((totalCount-1)/pageBlock) + 1);
	var previewPageNum = (currentPage == 1 ? 1 : currentPage - 1);
	var nextPageNum = (currentPage == lastPageNum ? lastPageNum : currentPage + 1);

	var indexNum = (currentPage <= navigatorNum  ? 0 : parseInt((currentPage-1)/navigatorNum) * navigatorNum);
  
	$("#"+objId + "Prev").html(
			( firstPageNum == currentPage ? "<div>&laquo;</div>" : "<div onclick='javascript:paging("+firstPageNum+");'><a href='#' style='font-family:sans-serif;'>&laquo;</a></div>" ) +
	        ( previewPageNum == currentPage ? "<div>&lsaquo;</div>" : "<div onclick='javascript:paging("+previewPageNum+");'><a href='#' style='font-family:sans-serif;'>&lsaquo;</a></div>" )
    	);

	var pagingHTML = "";
	for (var i = 1; i <= navigatorNum; i++) {
		var pageNum = i + indexNum;
		if ( pageNum == currentPage ) 
			pagingHTML += "		<li class='on'>"+pageNum+"</li>";
		else 
			pagingHTML += "		<li onclick='javascript:paging("+pageNum+");'><a href='#'>"+pageNum+"</a></li>";
		
		if ( pageNum == lastPageNum )
			break;
	}
	$("#"+objId).html(pagingHTML);

	$("#"+objId + "Next").html(
			( nextPageNum == currentPage ? "<div>&rsaquo;</div>" : "<div onclick='javascript:paging("+nextPageNum+");'><a href='#' style='font-family:sans-serif;'>&rsaquo;</a></div>" ) +
			( lastPageNum == currentPage ? "<div>&raquo;</div>" : "<div onclick='javascript:paging("+lastPageNum+");'><a href='#' style='font-family:sans-serif;'>&raquo;</a></div>" )
    	);
}

/**
 * 페이징 검색
 * @param pPage
 */
function paging(pPage) {
	lfn_btn("paging", {page:pPage});
}	 
