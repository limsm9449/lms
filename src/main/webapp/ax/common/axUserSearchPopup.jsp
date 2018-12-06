<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>
</title>

<%@ include file="../../common/commAxAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var mask = new ax5.ui.mask();
var confirmDialog = new ax5.ui.dialog();
var dialog = new ax5.ui.dialog( { title: '<i class="axi axi-ion-alert"></i> Alert' } );
var grid = null;
var params = {}
var dd = {};

var kind = gfn_getUrlParams("kind");
var isTeacher = gfn_getUrlParams("isTeacher");

$(document.body).ready(function () {
	gfn_callAjax("/common/axDd.do", { DD_KIND : "Company,Sex" }, fn_callbackAjax, "dd", { async : false });
}); 

function fn_makeGrid() {
	grid = gfn_makeAx5Grid("first-grid",
		[ 	{
	            key : "USER_ID",
	            label : "사용자 ID",
	            width : 100,
	            align : "left"
	        },{
	            key : "USER_NAME",
	            label : "사용자명",
	            width : 90,
	            align : "left"
	        },{
	            key : "EMAIL",
	            label : "E-mail",
	            width : 150,
	            align : "left"
	        },{
	            key : "SEX",
	            label : "성별",
	            width : 80,
	            align : "center", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Sex
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Sex, "value",  this.item.SEX, "text");
	           	}
	        },{
	            key : "BIRTH_DAY",
	            label : "생일",
	            width : 80,
	            align : "center"
	        },{
	            key : "HOME_ZIPCODE",
	            label : "우편번호",
	            width : 80,
	            align : "left"
	        },{
	            key : "HOME_ADDR",
	            label : "집주소",
	            width : 200,
	            align : "left"
	        },{
	            key : "HOME_TEL",
	            label : "집 전화번호",
	            width : 100,
	            align : "left"
	        },{
	            key : "MOBILE",
	            label : "핸드폰",
	            width : 100,
	            align : "left"
	        },{
	        	key : "COMP_CD", 
	        	label : "회사", 
	            width : 140,
	        	align : "left", 
	        	editor: {
                    type : "select", 
                    config : {
                        columnKeys: { optionValue: "value", optionText: "text" },
                        options: dd.Company
                    },
	            	disabled : function () {
                        return true;
                    }
	        	},
	            formatter : function () {
	                return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text", true);
	           	}
			},{
			  	key : undefined, 
			  	label: "관리자", 
			  	columns: [	        
			        {
			        	key : "ADMIN_YN", 
			        	label : "어드민", 
			            width : 70,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    }
			        	}
			        },{
			        	key : "SITE_MANAGER_YN", 
			        	label : "사이트 관리자", 
			            width : 120,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    }
			        	}
			        },{
			        	key : "CONTENTS_MANAGER_YN", 
			        	label : "컨텐츠 관리자", 
			            width : 120,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    }
			        	}
			        },{
			        	key : "TEACHER_YN", 
			        	label : "강사", 
			            width : 60,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    }
			        	}
			        },{
			        	key : "TUTOR_YN", 
			        	label : "튜터", 
			            width : 60,
			        	align : "center", 
			        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
			            	disabled : function () {
		                        return true;
		                    }
			        	}
			        }
				]
	        }	], 
	  	null,
	  	{
	  		showRowSelector : false,
	  		frozenColumnIndex : 3 
	  	}
	);
	
	$(window).trigger("resize");
}

function fn_params() {
	params.kind = kind;
	params.isTeacher = isTeacher;
	params.SEARCH_STR = $("#SEARCH_STR").val();	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/common/axUserSearchList.do", params, fn_callbackAjax, "search");
}

var rows = null;
function fn_callbackAjax(data, id) {
	if ( data.RtnMode == "ERROR" ) {
		mask.open();
		dialog.alert( { msg : "처리시 오류가 발생했습니다. 관리자에게 문의하세요." }, function () { mask.close();	fn_search(); } );
		return;
	}
	
	if ( id == "search" ) {
		rows = data.list;
		
		grid.setData(data.list);
	} else if ( id == "dd" ){
		dd = $.extend({}, data);

		dd.Company = [{value : "", text : ""}].concat(dd.Company);
		
		fn_makeGrid();
	}
}


function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		opener.fn_callbackAjax(rows[grid.getList("selected")[0].__index], "userSearch");
		window.close();
	} else if ( event == "DataChanged" ) {
	}
}

function fn_close() {
	window.close();
}


</script>

<body style="padding : 10px">

<h2>사용자 검색</h2>

<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색어</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:10px"></div>

<div style="height:500px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>
<div style="height:10px"></div>

<div class="form-group">
 	<div class="col-sm-offset-9 col-sm-3">
		<button class="btn btn-default" onclick="fn_search()">검색</button>
		<button class="btn btn-default" onclick="fn_close()">닫기</button>
 	</div>
</div>

</form>
	

</body>
</html>

