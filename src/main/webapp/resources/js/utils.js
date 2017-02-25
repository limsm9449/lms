/**
 * 전체 문자 변경..
 * @param str1
 * @param str2
 * @returns {String}
 */
String.prototype.replaceAll = function(str1, str2) {
	var temp_str = "";
	if (this.trim() != "" && str1 != str2) {
		temp_str = this.trim();
		while (temp_str.indexOf(str1) > -1){
			temp_str = temp_str.replace(str1, str2);
		}
	}
	return temp_str;
} 
