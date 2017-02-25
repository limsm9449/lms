/* last update 2014.08.21 edit */
function menuStart() {
  var menu = ".menu > li > a";
  var bar = $('.menu_bg');
  var selMenu = $(menu+"[class='here']");
  var ofsSel = selMenu.offset();
  var nRight = 75;
  var doAction = null;
  var openSub = null;
  var nInterval;
  var nInterval2;

  $(menu).bind("mouseenter focus",function() {
    clearTimeout(nInterval);
    clearTimeout(nInterval2);
    bar.stop();
    if (openSub!=null) rtnSubMenu(openSub);
    
    doAction = this;
    
    if ($(menu).not(this).hasClass('here')) {
      $(menu).removeClass('here');
    }
    var idx = $(menu).index(this);
    var ofs = $(this).offset();
    ($(this).next()).stop().slideDown('fast', function() {
      if ($('#header').hasClass('yesbg')) $('#header').removeClass('yesbg');
      $('#header').addClass('nobg');
    });
    openSub = $(this).next();
    
    if (bar.css('display')=='none') {
      bar.css('left', ofs.left-75);
      $(menu).eq(idx).addClass('here');
      bar.css('display','block');
    } else {
      bar.css('opacity', 1);
      bar.animate({left: ofs.left-75},'slow', function() { $(menu).eq(idx).addClass('here'); doAction = null; });
    }
  });
  
  $(menu).mouseleave(function() {
    if (doAction==this) {
      bar.stop();
      rtnMenuBg();
    } else if ($(this)!=selMenu) {
      nInterval = setTimeout(rtnMenuBg, 1000);
    }
    nInterval2 = setTimeout(rtnSubMenu, 1000, $(this).next());
  });
  
  $(menu).next().mouseenter(function() {
    clearTimeout(nInterval);
    clearTimeout(nInterval2);
  });
  $(menu).next().mouseleave(function() {
    nInterval = setTimeout(rtnMenuBg, 1000);
    nInterval2 = setTimeout(rtnSubMenu, 1000, $(this));
  });
  $('.menu > li:last-child>#menu_wrap>ul>li:last-child>ul>li:last-child>a').focusout(function(){
		$('.menu > li:last-child>#menu_wrap').stop().slideUp('fast');
	});
  
  function rtnMenuBg()
  {
    $(menu).not(selMenu).removeClass('here');
    if (ofsSel!=undefined) { 
      bar.animate({left: ofsSel.left-75},'slow', function() { $(menu).eq($(menu).index(selMenu)).addClass('here'); doAction = null; });
    } else {
      bar.fadeOut('slow', function() {
        bar.css('display','none');
      });
    }
  }
  function rtnSubMenu(_sub)
  {
    _sub.stop().slideUp('fast', function() 
    {
      if ($('#header').hasClass('nobg')) $('#header').removeClass('nobg');
      $('#header').addClass('yesbg');
    });
    if (openSub==_sub) openSub = null;
  }
  
  if (ofsSel!=undefined) { 
    //bar.animate({left: ofsSel.left-nRight},'fast'); /* 2014.08.08 del p080802 */
    bar.css('left',ofsSel.left-nRight +"px");   /* 2014.08.08 add p080802 */
  } else {
    bar.css('display','none');
  }
}