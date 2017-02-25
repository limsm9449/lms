function callSwf(_swf, _div, _w,_h, _id, _data, _mode, _bg, _focus)
{
  var F_swf =(_swf==null)? '/resources/swf/mainContentview.swf':_swf;
  var F_div =(_div==null)? 'flashDiv':_div;
	var F_w   =(_w==null)?  '100%':_w;
	var F_h   =(_h==null)? '850':_h;
	var F_id  =(_id==null)? 'contentViewSwf':_id;
	
	var para = {
	  wmode: (_mode==null)? 'transparent':_mode,
	  allowScriptAccess: 'always',
	  FlashVars: (_data==null)? "":_data,
	  bgColor: (_bg==null)? '#FFFFFF':_bg
	};
	var attri = {
	  id: F_id,
	  name: F_id
	};
	
  //flash onload event
  if (_focus!=null) {
	  var callbackFn = function() { getSWF(F_id).focus();};
	} else {
	  var callbackFn = null;
	}
	
  swfobject.embedSWF(F_swf, F_div, F_w, F_h, '10.0.0',null,null, para, attri, callbackFn);
}

//flash�� ����ϱ� ���� �Լ�
function getSWF(movieName)
{
    if (document[movieName]==undefined) {
        return window[movieName];
    } else {
        return document[movieName];
    }
}