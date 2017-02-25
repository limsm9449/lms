<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

<style>
  .file_btn_group { position:relative; left: 80px; width: 70px; height: 23px; overflow: hidden; margin-bottom: 5px; }
  .file_button { position: absolute; top:0px; }
  .hidden_inputfile { cursor:pointer; font-size: 45px; position: absolute; right: 0px; top: 0px; opacity: 0; filter: alpha(opacity=0); -ms-filter: "alpha(opacity=0)"; -khtml-opacity: 0; -moz-opacity: 0; }
</style>


</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="upload" ) {
		if ( pParam.kind == "SWF" && isExtention($("#swfFile").val(),"swf") == false ) {
			alert("플래시 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "B_IMG" && isExtention($("#bImgFile").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "C_IMG" && isExtention($("#cImgFile").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "M_IMG1" && isExtention($("#mImg1File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "M_IMG2" && isExtention($("#mImg2File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "M_IMG3" && isExtention($("#mImg3File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "S_IMG1" && isExtention($("#sImg1File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "S_IMG2" && isExtention($("#sImg2File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		} else if ( pParam.kind == "S_IMG3" && isExtention($("#sImg3File").val(),"jpg") == false ) {
			alert("JPG 파일을 선택해주세요.")
			return;
		}
		
		$("#kind").val(pParam.kind);

		document.frm.action = context + "/courseImage/uploadImage.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind =="refresh" ) {
		gfn_goPage("/courseImage/courseImageV",$("#frm").serialize());	
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseImage/courseImageList',top.gCondition.courseImage.param); 
	}
}

function isExtention(fileName, compExt) {
	var ext = fileName.substring(fileName.lastIndexOf(".") + 1,  fileName.length);
	if ( ext.toLowerCase() == compExt.toLowerCase() )
		return true;
	else 
		return false;
	
}
</script>

<body>

<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">
<input id="kind" name="kind" type="hidden" value=""/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 이미지 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 이미지 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">과정 이미지 상세</h3>
		    	
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="170"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th><span class="con_name">과정명</span></th>
							<td class="no_line">
								<input id="courseCode" name="courseCode" type="hidden" value="${set.data.courseCode}"/>
								<span class="con_name">${set.data.courseName}</span>
							</td>
						</tr>
						<tr>
							<th >메인 플래시<p class="desc">swf.swf(1300*850)</p></th>
							<td class="no_line">
<c:if test="${set.data.swf eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.swf eq 'Y'}">							
								<div class="flash_box">등록됨</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="swfFile" id="swfFile" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'SWF'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >메인 배경 이미지<p class="desc">bImg.jpg(1300*850)</p></th>
							<td class="no_line">
<c:if test="${set.data.bImg eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.bImg eq 'Y'}">
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/bImg.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="bImgFile" id="bImgFile" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'B_IMG'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 상세 이미지<p class="desc">cImg.jpg(356*237)</p></th>
							<td class="no_line">
<c:if test="${set.data.cImg eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.cImg eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/cImg.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="cImgFile" id="cImgFile" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'C_IMG'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 미리보기 이미지1<p class="desc">mImg1.jpg(374*235)</p></th>
							<td class="no_line">
<c:if test="${set.data.mImg1 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.mImg1 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/mImg1.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="mImg1File" id="mImg1File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'M_IMG1'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 미리보기 이미지2<p class="desc">mImg2.jpg(374*235)</p></th>
							<td class="no_line">
<c:if test="${set.data.mImg2 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.mImg2 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/mImg2.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="mImg2File" id="mImg2File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'M_IMG2'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 미리보기 이미지3<p class="desc">mImg3.jpg(374*235)</p></th>
							<td class="no_line">
<c:if test="${set.data.mImg3 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.mImg3 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/mImg3.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="mImg3File" id="mImg3File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'M_IMG3'}); return false;">
							    </div>								
							</td>
						</tr>


						<tr>
							<th >과정 썸네일1<p class="desc">sImg1.jpg(120*75)</p></th>
							<td class="no_line">
<c:if test="${set.data.sImg1 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.sImg1 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/sImg1.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="sImg1File" id="sImg1File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'S_IMG1'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 썸네일2<p class="desc">sImg2.jpg(120*75)</p></th>
							<td class="no_line">
<c:if test="${set.data.sImg2 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.sImg2 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/sImg2.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="sImg2File" id="sImg2File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'S_IMG2'}); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >과정 썸네일3<p class="desc">sImg3.jpg(120*75)</p></th>
							<td class="no_line">
<c:if test="${set.data.sImg3 eq 'N'}">							
								<div class="flash_box_no">미등록</div>
</c:if>								
<c:if test="${set.data.sImg3 eq 'Y'}">							
								<div class="img_box"><img src="/cImage/contents/${set.data.courseCode}/sImg3.jpg" /></a>
								</div>
</c:if>								
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="sImg3File" id="sImg3File" class="hidden_inputfile" title="" onChange="lfn_btn('upload',{kind:'S_IMG3'}); return false;">
							    </div>								
							</td>
						</tr>
												
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>


