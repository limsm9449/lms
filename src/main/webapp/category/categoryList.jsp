<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">

$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/category/categoryList");	
	}
}

function f_add(depth) {
	if ( depth == "1") {
		Popup.showPopup("/category/category1DepthN.do",440,210,"categoryDiv");	
	} else if ( depth == "2") {
		Popup.showPopup("/category/category2DepthN.do",440,250,"categoryDiv");	
	} else if ( depth == "3") {
		Popup.showPopup("/category/category3DepthN.do",440,240,"categoryDiv");	
	}
}

function f_update(depth,code) {
	Popup.showPopup("/category/categoryU.do?code=" + code + "&depth=" + depth,440,280,"categoryDiv");	
}

</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">카테고리 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li class="last">카테고리 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">카테고리 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">카테고리</label>
		              	<select id="c1Code" name="c1Code" onchange="gfn_category1Change()">
			              	<option value="">전체</option>
							<c:forEach var="row" items="${set.ddCategory1Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c1Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c2Code" name="c2Code" onchange="gfn_category2Change()">
			              	<option value="">전체</option>
			              	<c:forEach var="row" items="${set.ddCategory2Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c2Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c3Code" name="c3Code">
			             	<option value="" selected>전체</option>
			             	<c:forEach var="row" items="${set.ddCategory3Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c3Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<p class="comment">등록하신 과정에 대해 확인하실 수 있습니다.</p>
		   		<table summary="No., 카테고리, 과정코드, 과정명, 화면크기, 경로, Point, 사용여부">
					<caption>등록된 과정 코드 목록</caption>
					<thead>
					  	<tr class="guide">
	  						<th width="120"></th>
	  						<th width="100"></th>
	  						<th width="120"></th>
	  						<th width="100"></th>
	  						<th width="120"></th>
	  						<th></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>대분류 코드 <a href="#" onclick="javascript:f_add('1');return false;" class="blueBtn">+</a></th>
							<th>대분류 명</th>
							<th>중분류 코드 <a href="#" onclick="javascript:f_add('2');return false;" class="blueBtn">+</a></th>
							<th>중분류 명</th>
							<th>소분류 코드 <a href="#" onclick="javascript:f_add('3');return false;" class="blueBtn">+</a></th>
							<th>소분류 명</th>
							<th class="no_line">사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject">${row.c1Code}</td>
				              	<td class="subject"><a href="#" onclick="javascript:f_update('1','${row.c1Code}');return false;" class="click">${row.c1CodeName}</a></td>
				              	<td class="subject">${row.c2Code}</td>
				              	<td class="subject"><a href="#" onclick="javascript:f_update('2','${row.c2Code}');return false;" class="click">${row.c2CodeName}</a></td>
				              	<td class="subject">${row.c3Code}</td>
				              	<td class="subject"><a href="#" onclick="javascript:f_update('3','${row.c3Code}');return false;" class="click">${row.c3CodeName}</a></td>
				              	<td class="no_line center">${row.useYn}</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
				</div>
		   	</div>
		</div>
	</div>
</div>	

</form>
	

</body>
</html>

