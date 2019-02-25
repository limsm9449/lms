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
var COMPANY2 = gfn_getUrlParams("COMPANY2");

$(document.body).ready(function () {
	gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel1,CompanyKind,Company,Company1,Company2" }, fn_callbackAjax, "dd", { async : false });
	
	if ( COMPANY2 != "" ) {
		$("#div1").hide();
	}
}); 

function fn_makeGrid() {
	var columns = [];
	columns.push( {
        key : "COURSE_ID",
        label : "ID",
        width : 40,
        align : "right"
    } );
	columns.push( {
        key : "CATEGORY_NAME",
        label : "카테고리",
        width : 150,
        align : "left"
    } );
	columns.push( {
        key : "COURSE_NAME",
        label : "과정명",
        width : 150,
        align : "left"
    } );
	columns.push( {
        key : "COURSE_CODE",
        label : "과정코드",
        width : 90,
        align : "left"
    } );
	columns.push( {
        key : "YEAR", 
        label : "년",
        width : 50,
        align : "center"
    } );
	columns.push( {
        key : "MONTH",
        label : "월",
        width : 50,
        align : "center"
    } );
	columns.push( {
        key : "CHASU",
        label : "차수",
        width : 50,
        align : "right"
    } );
	columns.push( {
    	key : "COMP_CD", 
    	label : "회사", 
        width : 100,
    	align : "center", 
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
            return gfn_getValueInList(dd.Company, "value",  this.item.COMP_CD, "text");
       	}
    } );
	columns.push( {
    	key : "TARGET_COMP_CD", 
    	label : "등록할 회사", 
        width : 110,
    	align : "center", 
    	editor: {
            type : "select", 
            config : {
                columnKeys: { optionValue: "value", optionText: "text" },
                options: dd.Company
            },	            	
			disabled : function () {
                   return ( kind == "COURSE_MODE" ? false : true );
               }
    	},
        formatter : function () {
            return gfn_getValueInList(dd.Company, "value",  this.item.TARGET_COMP_CD, "text");
       	},
		styleClass: function () {
            return ( kind == "COURSE_MODE" ? "grid-cell-edit" : "" );
        }
    } );
	columns.push( {
        key : "COURSE_COST",
        label : "과정비용",
        width : 90,
        align : "right",
        editor : { 
        	type : "number",
        	disabled : function () {
                return true;
            }
		},
        formatter : function () {
            return checkThousand(this.item.COURSE_COST);
       	}
    } );
	columns.push( {
      	key : undefined, 
      	label: "기간", 
      	columns: [	        
      		{
	        	key : "TERM_YN", 
	        	label : "가입기간 여부", 
	            width : 110,
	        	align : "center", 
	        	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
	            	disabled : function () {
                        return true;
                    } 
	        	}
	        },{
	            key : "TERM_PERIOD_FROM",
	            label : "가입 시작일",
	            width : 110,
	            align : "center",
	            editor : { 
	            	type : "date",
	            	disabled : function () {
                        return true;
                    }
				}
	        },{
	            key : "TERM_PERIOD_TO",
	            label : "가입 종료일",
	            width : 110,
	            align : "center",
	            editor : { 
	            	type : "date",
	            	disabled : function () {
                        return true;
                    }
				}
	        },{
	            key : "STUDY_PERIOD_FROM",
	            label : "학습 시작일",
	            width : 110,
	            align : "center",
	            editor : { 
	            	type : "date",
	            	disabled : function () {
                        return true;
                    }
				}
	        },{
	            key : "STUDY_PERIOD_TO",
	            label : "학습 종료일",
	            width : 110,
	            align : "center",
	            editor : { 
	            	type : "date",
	            	disabled : function () {
                        return true;
                    }
				}
	        },{
	            key : "C_PERIOD",
	            label : "교육일수",
	            width : 80,
	            align : "right",
	            editor : { 
	            	type : "number",
	            	disabled : function () {
                        return true;
                    }
				},
	            formatter : function () {
	                return this.item.C_PERIOD + " 일";
	           	}
	        }
        ]
    } );
	columns.push( {
    	key : "MOBILE_YN", 
    	label : "모바일", 
        width : 60,
    	align : "center", 
    	editor : { type : "checkbox", config : {height: 17, trueValue: "Y", falseValue: "N"},
        	disabled : function () {
                return true;
            }
    	}
    } );
	grid = gfn_makeAx5Grid("first-grid", columns, null, { showRowSelector : false, frozenColumnIndex : 7 } );
	
	$(window).trigger("resize");
}

function fn_params() {
	params.kind = kind;
	params.SEARCH_STR = $("#SEARCH_STR").val();
	
	if ( COMPANY2 != "" ) {
		params.COMPANY2 = COMPANY2;	
	} else {
		params.COMPANY = $("#CB_COMPANY option:selected").val();	
		params.COMPANY2 = $("#CB_COMPANY2 option:selected").val();	
	}

	params.LEVEL1_CODE = $("#CB_LEVEL1 option:selected").val();	
	params.LEVEL2_CODE = $("#CB_LEVEL2 option:selected").val();	
	params.LEVEL3_CODE = $("#CB_LEVEL3 option:selected").val();	
}

function fn_search() {
	fn_params();
	
	gfn_callAjax("/common/axCourseSearchList.do", params, fn_callbackAjax, "search");
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
		
		gfn_cbRefresh("CB_COMPANY", data.CompanyKind, true);
		gfn_cbRefresh("CB_LEVEL1", data.CategoryLevel1, true);
		
		fn_makeGrid();
	} else if ( id == "CB_LEVEL1" ){
		gfn_cbRefresh("CB_LEVEL2", data.CategoryLevel2, true);
	} else if ( id == "CB_LEVEL2" ){
		gfn_cbRefresh("CB_LEVEL3", data.CategoryLevel3, true);
	} else if ( id == "companyDomain" ) {
		var row = grid.getList("selected");
		if ( row.length > 0 ) {
	   		window.open("","courseDataPopup","width=1400,height=900");
	   		document.frm.action = "http://" + data.domain + "." + window.location.host + "/main/mainCourseData.do" + "?" + "courseId=" + row[0].COURSE_ID;
	   		console.log(document.frm.action);
	   		document.frm.target = "courseDataPopup";
	   		document.frm.method = "POST";	
	   		document.frm.submit();
		}
	}
}


function fn_gridEvent(event, obj) {
	if ( event == "Click" ) {
		obj.self.select(obj.dindex);
	} else if ( event == "DBLClick" ) {
		if ( kind == "COURSE_MODE") {
			opener.fn_callbackAjax(rows[grid.getList("selected")[0].__index], "courseSearch");
			window.close();
		}
		if ( obj.column.key == "COURSE_ID" ) {
			if ( obj.item.COMP_CD == "B2C" ) {
    			f_popup('/main/mainCourseData', {displayName:'courseDataPopup',option:'width=1400,height=900', urlParams : "courseId=" + obj.item.COURSE_ID});
        	} else {
        		gfn_callAjax("/setting/axMainFrameCompanyDomain.do", { COMP_CD : obj.item.COMP_CD }, fn_callbackAjax, "companyDomain");
        	}
		}
	} else if ( event == "DataChanged" ) {
	}
}

function fn_cbChange(id) {
	if ( id == "CB_LEVEL1" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel2", LEVEL1_CODE : $("#CB_LEVEL1 option:selected").val()}, fn_callbackAjax, "CB_LEVEL1", { async : false });
	} else  if ( id == "CB_LEVEL2" ) {
	    gfn_callAjax("/common/axDd.do", { DD_KIND : "CategoryLevel3", LEVEL2_CODE : $("#CB_LEVEL2 option:selected").val()}, fn_callbackAjax, "CB_LEVEL2", { async : false });
	} else if ( id == "CB_COMPANY" ) {
		if ( $("#CB_COMPANY").val() == "B2B" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company1, true);
		} else if ( $("#CB_COMPANY").val() == "C2C" ) {
			gfn_cbRefresh("CB_COMPANY2", dd.Company2, true);
		} else {
			gfn_cbRefresh("CB_COMPANY2", null, true);
		}
	}
}

function fn_close() {
	window.close();
}


</script>

<body style="padding : 10px">

<h2>과정 검색</h2>

<div style="height:10px"></div>

<div class="form-inline">
  	<div class="form-group">
    	<label for="CB_LEVEL1">카테고리</label>
		<select class="form-control" id="CB_LEVEL1" onchange="fn_cbChange('CB_LEVEL1')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_LEVEL2" onchange="fn_cbChange('CB_LEVEL2')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_LEVEL3">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group" id="div1">
    	<label for="CB_COMPANY">&nbsp;회사 구분</label>
		<select class="form-control" id="CB_COMPANY" onchange="fn_cbChange('CB_COMPANY')">
			<option value="">전체</option>
		</select>
		<select class="form-control" id="CB_COMPANY2">
			<option value="">전체</option>
		</select>
  	</div>
  	<div class="form-group">
    	<label for="CB_SEARCHKIND">검색어</label>
		<input class="form-control" type="text" class="search_input" id="SEARCH_STR" name="SEARCH_STR" value="" />
  	</div>
</div>
<div style="height:15px"></div>
<div class="form-group">
		<button class="btn btn-default" onclick="fn_search()">검색</button>
		<button class="btn btn-default" onclick="fn_close()">닫기</button>
</div>

<div style="height:510px;" id="grid-parent">
    <div data-ax5grid="first-grid" style="height: 100%;"></div>
</div>

<form name="frm" id="frm" method="post"></form>

</form>
<div class="mask"></div>	

</body>
</html>

