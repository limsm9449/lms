function f_makePageNavigator(objId, currentPage, totalCount, pageBlock) {
	var navigatorNum    = 10;

	var firstPageNum  = 1;
	var lastPageNum = (pageBlock == 1 ? totalCount : parseInt((totalCount-1)/pageBlock) + 1);
	var previewPageNum = (currentPage == 1 ? 1 : currentPage - 1);
	var nextPageNum = (currentPage == lastPageNum ? lastPageNum : currentPage + 1);

	var indexNum = (currentPage <= navigatorNum  ? 0 : parseInt((currentPage-1)/navigatorNum) * navigatorNum);
  
	$("#"+objId + "Prev").html(
			"<div><a href='#' onclick='javascript:paging("+firstPageNum+");'>&laquo;</a></div>" +
	        "<div><a href='#' onclick='javascript:paging("+previewPageNum+");'>&lsaquo;</a></div>"
    	);

	var pagingHTML = "";
	for (var i = 1; i <= navigatorNum; i++) {
		var pageNum = i + indexNum;
		if ( pageNum == currentPage ) 
			pagingHTML += "		<li class='here'>"+pageNum+"</li>";
		else 
			pagingHTML += "		<li><a href='#' onclick='javascript:paging("+pageNum+");'>"+pageNum+"</a></li>";
		
		if ( pageNum == lastPageNum )
			break;
	}
	$("#"+objId).html(pagingHTML);

	$("#"+objId + "Next").html(
			"<div><a href='#' onclick='javascript:paging("+nextPageNum+");'>&rsaquo;</a></div>" +
	        "<div><a href='#' onclick='javascript:paging("+lastPageNum+");'>&raquo;</a></div>"
    	);
}

/**
 * 페이징 검색
 * @param pPage
 */
function paging(pPage) {
	lfn_btn("paging", {page:pPage});
}	 
