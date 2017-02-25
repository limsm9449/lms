/**
 * 카테고리 대분류 변경시 중분류 가져오기
 */
function gfn_category1Change() {
	$.ajax({
		type : "POST",
		url : context + "/common/ddCategory2Depth.do",
		dataType : "json",
		data : $("#frm").serialize(),
		success : function(json){
			$("#c2Code").html("");
			
			if ( json.length == 0 )
	 			$("#c2Code").append("<option value=''>" + resource.label.all + "</option>");
			else {
	 			$("#c2Code").append("<option value=''>" + resource.label.all + "</option>");
				for (var i = 0; i < json.length ; i++) {
					var obj = json[i];
					var opt = "";
					opt += "<option value='" + obj.ddKey + "'>";
					opt += obj.ddValue;
					opt += "</option>";
			 		$("#c2Code").append(opt);			
				}
			}
			
			//소분류 초기화
			$("#c3Code").html("");
			$("#c3Code").append("<option value=''>" + resource.label.all + "</option>");
			
			//과정이 있으면 초기화..
			if ( $("#courseCode").length > 0 ) {
				$("#courseCode").html("");
				$("#courseCode").append("<option value=''>" + resource.label.all + "</option>");
			}
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	})
}

/**
 * 카테고리 중분류 변경시 소분류 가져오기
 */
function gfn_category2Change() {
	$.ajax({
		type : "POST",
		url : context + "/common/ddCategory3Depth.do",
		dataType : "json",
		data : $("#frm").serialize(),
		success : function(json){
			$("#c3Code").html("");
			
			if ( json.length == 0 )
	 			$("#c3Code").append("<option value=''>" + resource.label.all + "</option>");
			else {
	 			$("#c3Code").append("<option value=''>" + resource.label.all + "</option>");
				for (var i = 0; i < json.length ; i++) {
					var obj = json[i];
					var opt = "";
					opt += "<option value='" + obj.ddKey + "'>";
					opt += obj.ddValue;
					opt += "</option>";
			 		$("#c3Code").append(opt);			
				}
			}
		},
		error : function(e) {
			alert(resource.msg.systemError);
		}
	})
}