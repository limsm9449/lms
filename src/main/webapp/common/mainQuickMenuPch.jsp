<%@ page contentType="text/html;charset=utf-8"%>

            <div class='quick_menu_wrap'>
                <div class='mobile_btn'>
                        <button onClick="sub_show_hide_pc(this)">
                            <span class='first'></span><span class='middle'></span><span class='last'></span>
                        </button>
                    </div>
                <ul>
                	<a href='#' onclick="page.goPage('/normalUser/attendCourseList', '');">
                    	<li class='quick_menu_list' id="q_menu1"></li>
                    </a>
                    <a href='#' onclick="page.goPage('/main/courseList', '');">
                    	<li class='quick_menu_list' id="q_menu2"></li>
                    </a>
                    <a href='#' onclick="page.goPage('/main/cart');">
                    	<li class='quick_menu_list' id="q_menu3"> </li>
                    </a>
                    <a href='#' onclick="page.goPage('/main/myOrder');">
                    	<li class='quick_menu_list' id="q_menu4"></li>
                    </a>
                    <a href='#' onclick="page.goPage('/main/noticeList', '');">
                    	<li class='quick_menu_list' id="q_menu5"></li>
                    </a>
<c:if test="${session.auth eq 'CHANNEL'}">                    
                    <a href='#' onclick="window.open(context + '/home/adminHome.do', '_blank');">
                    	<li class='quick_menu_list' id="q_menu6"></li>
                    </a>
</c:if>                    
                    <li class='quick_menu_list' id="q_menu7"></li>
                    <c:if test="${!empty cart}"><img src="/resources/homepagePch/img/main/quick/q_menu2_circle.png" alt=' ' id="q_menu2_circle"><span class="q_menu2_num">${cart.size()}</span></c:if>
                    
                </ul>
               <!-- 탑다운버튼1111111111111<p class='quick_top'>
                    <span>
                        <img src='/resources/homepagePch/img/main/quick/q_topbtn.png' alt=' '>
                    </span>
                </p>
                <p class='quick_down'>
                    <span>
                        <img src='/resources/homepagePch/img/main/quick/q_downbtn.png' alt=' '>
                    </span>
                </p>-->
            </div>