var offsetVal;
var index = 0;
var sindex = 0;
var offsetHeight = [0,980,1960,2940,3920,4900,5880,6860];
var old3 = 0;
var old4 = 0;
var timeout;
var _width; 
var _height; 
var _reconheight;
var _hct;
var idx;
var _imght;
var _count = 0;
var _hh;

var x;
var y;
var boxWidth;
var boxHeight;
var star1;
var star2;
var chknum;
var flag = true;
var currentindex = 0;
var inum;
var index1 = 0;
var index2 = 0;
var index3 = 0;
var index4 = 0;
var index5 = 0;
var index6 = 0;
var oldindex1 = 0;
var oldindex2 = 0;
var oldindex3 = 0;
var oldindex4 = 0;
var oldindex5 = 0;
var oldindex6 = 0;
var myVar1;
var myVar2;
var myVar3;
var myVar4;
var myVar5;
var myVar6;
var snum;
var gnbflag = true;
var topflag = false;
var stopidx;
var pchk = false;
var gnbBtnArr = [];
var introVar;
var introChk = false;
var mainVar;  
var _mh1;
var _mh2;
var parm = false;
var $clickTag;

window.trace = function() {
    try{
        //console.log.apply(console, arguments);
    }catch(er){
        //
    }
};

$(function(){
    
    introChk = true;
    
    $(".header h1").click(function(){
//        window.location.href="/"; //테스트용
//        window.location.href="/maintest.do"; //실서버용
        
        if(index== 1) return; //로고 클릭시 메인으로
        
        resetmain();
        pchk = false;
        sectionMov(1,2); // 메인
    });
    
});

$(window).load(function(){
    
    _width = $(window).width();
    _height = $(window).height();
    _reconheight= Math.floor($(".con .bg img").height()/6);
    _hct = Math.floor(_height - _reconheight )/2;
   
    //init    
    init();
    
    //이벤트 셋팅
    initEventListener();
   
    //GNB 셋팅
    initGnb();
  
    //offsetTop값 초기로드
    offsetTop();
   
    //scroll
    $(window).scroll(function() {
        offsetTop();
    });
    
    /** GNB 현재 메뉴 활성화   */
    currentMenuNum = 0;
    activationGNBMenu(currentMenuNum);
    
    /** GNB메뉴 핸들러   */
    gnbBtnArr = $(".gnb li");
    $(".gnb li a").bind("mouseenter", gnbHandler);
    $(".gnb li a").bind("mouseleave", gnbHandler);
    $(".gnb li a").bind("click", gnbHandler);

    $(".topMenu .ticket").bind("mouseenter", btnTicketHandler);
    $(".topMenu .ticket").bind("mouseleave", btnTicketHandler);
    $(".topMenu .ticket").bind("click", btnTicketHandler);
    
//    $(".firecon .ticket").bind("mouseenter", btnTicketHandler2);
//    $(".firecon .ticket").bind("mouseleave", btnTicketHandler2);
//    $(".firecon .ticket").bind("click", btnTicketHandler2);
    
    $(".firecon .firetxt1").bind("mouseenter", btnphotoHandler)
    $(".firecon .firetxt1").bind("mouseleave", btnphotoHandler)
    $(".firecon .firetxt1").bind("click", btnphotoHandler)
    
    $(".scrolldown").bind("click", scrollclickHandler);
    
    pictohandler_on();
    
     //파라미터
    Request();  
    var request = new Request();
//    request.getParameter('section')
    if(request.getParameter('section') == 'main'){
        
        resetmain();
        pchk = false;
        sectionMov(1,2); //메인
        soundflash();
        
        parm = false;
        $("#spin").hide();
    }else if(request.getParameter('section') == 1){
        resetmain();
        pchk = true;
        sectionMov(2,2); //축제안내
        soundflash();
        
        gnbflag = true;
        parm = true;
        $("#spin").hide();
    }else if(request.getParameter('section') == 2){
        resetmain();
        pchk = true;
        sectionMov(3,2); //불꽃정보
        soundflash();
        
        gnbflag = true;
        parm = true;
        $("#spin").hide();
    }else if(request.getParameter('section') == 3){
        resetmain();
        pchk = true;
        sectionMov(4,2); //안전지침
        soundflash();
        
        gnbflag = true;
        parm = true;
        $("#spin").hide();
        
    }else if(request.getParameter('section') == 4){
        resetmain();
        pchk = true;
        sectionMov(5,2); //운영센터
        soundflash();
        
        gnbflag = true;
        parm = true;
        $("#spin").hide();
        
    }else{
        //인트로시작
        introChk = true;
         soundflash();
        $(".intro").css({"display":"block"})
        $(".skipbtn").css({"display":"block"})
        $(".mute").css({"display":"block"})
        sectionMov(0);
        introflash();
        $("#spin").hide();
        
        setTimeout(function() {
            $(".skipbtn > a").focus();
        }, 500);
    }
//     GNB 티켓모션    
    gnbticketplay();
    
    $(".gomenu").click(function() {
        $("#gnbtab li:first-child > a").focus();
        return false;
    });
    $(".gomenu").focusin(function() {
        $(this).parent().addClass("section_menu");
    }).focusout(function() {
        $(this).parent().removeClass("section_menu");
    });
    $(".wrap").keydown(function(e) {
        if(e.keyCode == 9) {
            // 섹션 이동중일 경우 탭키 무효화...
            if(isSectionMoving) return false;
            
            var $focused = $(':focus');
            var tidx = $focused.data('tab');
            if(typeof(tidx) != 'undefined') {
                tidx = parseInt(tidx, 10);
                if(index != tidx) {
                    if(tidx == -1) tidx = index;
                    sectionMov(tidx, 0);
                    return false;
                }
            }
        }
    });

    $(".pictobox > a").focusin(function(){
        var pname = $(this).attr("class");
        pictooverHandler(pname);
    });
    
    $(".pictobox > a").focusout(function(){
        var pname = $(this).attr("class");
        pictooutHandler(pname);
    });
});

//트래킹함수
function checkTrack(btnName){
    ga('send', 'event', btnName);
    dcsMultiTrack(
    'DVS.dvssip',location.hostname,
    'DCS.dcsuri',location.pathname,
    'WT.ti',btnName);
}

function pictohandler_on(){
    //픽토오버핸들러
    $(".boxover .box1").bind("mouseenter", pictooverHandler);
    $(".boxover .box1").bind("mouseleave", pictooutHandler);
    $(".boxover .box1").bind("click", pictoclickHandler);
    $(".pictobox .pbox1").bind("click", pictoclickHandler);
    
    $(".boxover .box2").bind("mouseenter", pictooverHandler);
    $(".boxover .box2").bind("mouseleave", pictooutHandler);
    $(".boxover .box2").bind("click", pictoclickHandler);
    $(".pictobox .pbox2").bind("click", pictoclickHandler);
    
    $(".boxover .box3").bind("mouseenter", pictooverHandler);
    $(".boxover .box3").bind("mouseleave", pictooutHandler);
    $(".boxover .box3").bind("click", pictoclickHandler);
    $(".pictobox .pbox3").bind("click", pictoclickHandler);
}

function pictohandler_off(){
    //픽토오버핸들러
    $(".boxover .box1").unbind("mouseenter", pictooverHandler);
    $(".boxover .box1").unbind("mouseleave", pictooutHandler);
    
    $(".boxover .box2").unbind("mouseenter", pictooverHandler);
    $(".boxover .box2").unbind("mouseleave", pictooutHandler);
    
    $(".boxover .box3").unbind("mouseenter", pictooverHandler);
    $(".boxover .box3").unbind("mouseleave", pictooutHandler);
}

function resetmain(){
    introChk = false;
    $(".intro").empty();
    $(".skipbtn").empty();
    $(".mute").empty();
    $(".line").css("opacity", "1");
//    $(".main").stop().css("display","block");
//    $("section").stop().css("display","block");
    
    $(".main").show();
    $("section").show();
    $("section").stop().css("opacity", "1");
    $(".starcon").stop().css("opacity", "1");
}


function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName];

    } else {
        return document[movieName];
    }
}
//인트로 사운드 컨드롤
var soundchk = 1;
function soundcontrol(){
    if(soundchk == 0){
      $(".mutebtn1 a").css({opacity:0});
      $(".mutebtn0 a").css({opacity:1});
      thisMovie("evtFlash2").CallPlaySound();
      soundchk = 1;
    }else if(soundchk == 1){
      $(".mutebtn1 a").css({opacity:1});
      $(".mutebtn0 a").css({opacity:0});
      thisMovie("evtFlash2").CallStopSound();
      soundchk = 0;
    }
}

//인트로 스킵
function introskip(){
    $(".mute").empty();
    $(".main").show();
    $("section").show();
    checkTrack("Intro_skip");
    
    $("#spin").show();
    $(".intro").empty();
    $(".skipbtn").empty();
    
    mainVar = setTimeout(function(){mainTimeView();},300);
    $(".line").css("opacity", "1")
    
    clearTimeout(introVar);
    sectionMov(1,2);
    $("header h1 a").focus();
    
//    soundflash();
}
function mainTimeView(){
//    $(".main").stop().css("display","block");
    $(".main").show();
    clearTimeout(mainVar);
    $("header h1 a").focus();
    //생중계팝업 추가
//    window.open("/popup/popup_stream.html", "_blank", "toolbar=no, scrollbars=no, resizable=no, top=100, left=500, width=560, height=375");
}

// 인트로 플래시 불러오기
function introflash() {
    soundflash();
    
    $(".main").hide();
    $("section").hide();
    
    checkTrack("Intro");
    TweenLite.to( $(".skipbtn"), 0.8, {opacity:1, ease:"Sine.easeOut"});
    TweenLite.to( $(".mute"), 0.8, {opacity:1, ease:"Sine.easeOut"});
     $("html").unbind("mousewheel", mouseWheelHandler);  
     $("body").unbind("keyup", keyHandler);
    
    var flashVersion = swfobject.getFlashPlayerVersion();

    if (flashVersion.major >= 10) {
        var flashVars = "";
        var params = { allowScriptAccess: 'always', allowFullScreen: 'true', wmode: 'transparent' };
        var attr = { id: "evtFlash", name: "evtFlash" };
        swfobject.embedSWF("http://cdn.hanwhafireworks.com/web/images/main/swf/hanwhaintro.swf?rand=" + Math.random() * 100000, "IntroFlashBox", "1920", "980", '10', 'http://cdn.hanwhafireworks.com/web/images/main/swf/expressinstall.swf', flashVars, params, attr);
    }
    else {
//        alert("아래 링크를 사용하여 Flash를 재설치 해주세요.");
        nonFlash = '<div id="nonFlash" style="padding-top:20px; margin: 50px 100px; text-align:center;" >플래시 파일이 안보이시면 아래 Flash Player를 설치하신 후 인터넷창을 새로 열어서 확인바랍니다.<p style="padding-top:25px;"><a href="http://get.adobe.com/kr/flashplayer/" target="_blank"><img src="http://cdn.hanwhafireworks.com/web/images/main/swf/flash_128.jpg" alt /></a> </p></div>';
        $("#evtFlash").css("display","block");
        $("#evtFlash").html(nonFlash);
        
    }
}   

// 버튼 플래시 불러오기
function flashVerChk() {
    var flashVersion = swfobject.getFlashPlayerVersion();

    if (flashVersion.major >= 10) {
        var flashVars = "";
        var params = { allowScriptAccess: 'always', allowFullScreen: 'true', wmode: 'transparent' };
        var attr = { id: "evtFlash", name: "evtFlash" };
        swfobject.embedSWF("http://cdn.hanwhafireworks.com/web/images/main/swf/hanwhabtn.swf?rand=" + Math.random() * 100000, "EvtFlashBox", "290", "290", '10', 'http://cdn.hanwhafireworks.com/web/images/main/swf/expressinstall.swf', flashVars, params, attr);
    }
    else {
//        alert("아래 링크를 사용하여 Flash를 재설치 해주세요.");
        nonFlash = '<div id="nonFlash" style="padding-top:20px; margin: 50px 100px; text-align:center; " >플래시 파일이 안보이시면 아래 Flash Player를 설치하신 후 인터넷창을 새로 열어서 확인바랍니다.<p style="padding-top:25px;><a href="http://get.adobe.com/kr/flashplayer/" target="_blank"><img src="http://cdn.hanwhafireworks.com/web/images/main/swf/flash_128.jpg" alt /></a> </p></div>';
        $("#evtFlash").css("display","block");
        $("#evtFlash").html(nonFlash);
    }
}   


// 사운드 플래시 불러오기
function soundflash() {
    var flashVersion = swfobject.getFlashPlayerVersion();

    if (flashVersion.major >= 10) {
        var flashVars = "";
        var params = { allowScriptAccess: 'always', allowFullScreen: 'true', wmode: 'transparent' };
        var attr = { id: "evtFlash", name: "evtFlash2" };
        swfobject.embedSWF("http://cdn.hanwhafireworks.com/web/images/main/swf/hanwhasound.swf?rand=" + Math.random() * 100000, "SoundFlashBox", "21", "17", '10', 'http://cdn.hanwhafireworks.com/web/images/main/swf/expressinstall.swf', flashVars, params, attr);
    }
    else {
//        alert("아래 링크를 사용하여 Flash를 재설치 해주세요.");
        nonFlash = '<div id="nonFlash" style="padding-top:20px; margin: 50px 100px; text-align:center; " >플래시 파일이 안보이시면 아래 Flash Player를 설치하신 후 인터넷창을 새로 열어서 확인바랍니다.<p style="padding-top:25px;><a href="http://get.adobe.com/kr/flashplayer/" target="_blank"><img src="http://cdn.hanwhafireworks.com/web/images/main/swf/flash_128.jpg" alt /></a> </p></div>';
        $("#evtFlash").css("display","block");
        $("#evtFlash").html(nonFlash);
    }
}   

function pictooverHandler(pname){
    var name = $(this).attr("class");
    if(name == "box1" || pname == "pbox1"){
        $(".boxover .box1").css({opacity:1});
        pictoplay(1);
    }else if(name == "box2"|| pname == "pbox2"){
        $(".boxover .box2").css({opacity:1});
         pictoplay(2);
    }else if(name == "box3"|| pname == "pbox3"){
        $(".boxover .box3").css({opacity:1});
         pictoplay(3);
    }
}

function pictooutHandler(pname){
    var name = $(this).attr("class");
    if(name == "box1"|| pname == "pbox1"){
        pictostop(1);
    }else if(name == "box2"|| pname == "pbox2"){
        pictostop(2);
    }else if(name == "box3"|| pname == "pbox3"){
        pictostop(3);
    }
}
function pictoclickHandler(e){
    var name = $(this).parent().parent().attr('class');
    var index = $(this).index();
//    try{
//        console.log("section = "+name +"/// index = "+index );
//    }catch(exception){}
    $clickTag = $(this).parent().parent().find(".pictobox > a").eq(index);
    
    if(name == "section2"){ 
        if(index ==0){
            checkTrack("campaign");
            subpage('about.html?page=1');
        }else if(index == 1){
            checkTrack("campaign_s1");
            subpage('about.html?page=2');
        }else if(index == 2){
            checkTrack("campaign_s1");
            subpage('about.html?page=2');
        }
    }else if(name == "section3"){
        if(index ==0){
            checkTrack("hanwha fire");
            subpage('festival.html?page=1');
        }else if(index == 1){
            checkTrack("webzine");
            subpage('festival.html?page=2');
        }else if(index == 2){
            checkTrack("2014fireworks");
            subpage('festival.html?page=3');
        }
    }else if(name == "section4"){
        if(index ==0){
            checkTrack("fire what");
            subpage('information.html?page=1');
        }else if(index == 1){
            checkTrack("fire how");
            subpage('information.html?page=2');
        }else if(index == 2){
            checkTrack("fire design");
            subpage('information.html?page=3');
        }
    }else if(name == "section5"){
        if(index ==0){
            checkTrack("notice");
        }else if(index == 1){
            checkTrack("question");
        }else if(index == 2){
            checkTrack("direct");
        }
    }
}

function scrollclickHandler(e){
    var name = $(this).parent().attr('class');
    
    if(name == "section2"){ //축제안내
        sectionMov(3,3);
    }else if(name == "section3"){//불꽃정보
        sectionMov(4,3);
    }else if(name == "section4"){//안전지침    
        sectionMov(5,3);
    }else if(name == "section5"){//운영센터
        sectionMov(6,0);
    }
}

function pictoplay(num){
    $(".box"+num+" .boxbg").css({opacity:0})
    TweenLite.to( ".box"+num+" .boxbg", 0.4, {opacity:1, ease:"Sine.easeOut",onComplete:pictobgcomplete, onCompleteParams:[num]});
    
    $(".box"+num+" .boxplus").css({opacity:0})
    TweenLite.to( ".box"+num+" .boxplus", 1.5, {opacity:1, ease:"Sine.easeOut"});  
}
function pictobgcomplete(num){
    $(".box"+num+" .boxtxt1").css({top:134, opacity:0})
    TweenLite.to( ".box"+num+" .boxtxt1", 0.5, {top:124, opacity:1, ease:"Sine.easeOut"});
    
    $(".box"+num+" .boxicon").css({top:54, opacity:0})
    TweenLite.to( ".box"+num+" .boxicon", 0.6, {top:24, opacity:1, ease:"Sine.easeOut"});
    
    $(".box"+num+" .boxtxt2").css({top:206, opacity:0})
    TweenLite.to( ".box"+num+" .boxtxt2", 0.6, {  top:216, opacity:1, ease:"Sine.easeOut"});
}

function pictostop(num){
    $(".box"+num+" .boxbg").css({opacity:0})
    $(".box"+num+" .boxicon").css({opacity:0})
    $(".box"+num+" .boxtxt1").css({ opacity:0})
    $(".box"+num+" .boxtxt2").css({ opacity:0})
    $(".box"+num+" .boxplus").css({opacity:0})
    TweenLite.killTweensOf(".box"+num+" .boxbg");
    TweenLite.killTweensOf(".box"+num+" .boxicon");
    TweenLite.killTweensOf(".box"+num+" .boxtxt1");
    TweenLite.killTweensOf(".box"+num+" .boxtxt2");
    TweenLite.killTweensOf(".box"+num+" .boxplus");
}

/** GNB 핸들러 */
function gnbHandler(e){
    var idx = $('.gnb li').index($(this).parent('li'));
//    var idx = $(this).index();
    if(idx == currentMenuNum) return;
    switch(e.type)
    {
        case "mouseenter" : activationGNBMenu(idx); break;
        case "mouseleave" : activationGNBMenu(currentMenuNum); break;
        case "click" : 
            currentMenuNum = idx;
            activationGNBMenu(currentMenuNum);
            break;
    }
}
/** GNB메뉴 활성화   */
function activationGNBMenu(idx){
    var i = 0;
    for (i = 0; i < gnbBtnArr.length; i++) {
        if(i == idx){
            TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_off"), 0.65, {opacity:0, ease:"Cubic.easeOut"});
            TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_on"), 0.65, {opacity:1, width:24, height:24, "margin-top":0, "margin-left":18,
                                                                         ease:"Cubic.easeOut"});
            TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_on img"), 0.65, {top:0, left:0, ease:"Cubic.easeOut"});
            TweenLite.to( $(gnbBtnArr[i]).find(".gnb_txt"), 0.65, {opacity:1, ease:"Cubic.easeOut"});
        }else{
            if(i != currentMenuNum){
                TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_off"), 0.65, {opacity:1, ease:"Cubic.easeOut"});
                TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_on"), 0.65, {opacity:0, width:0, height:0, "margin-top":12, "margin-left":30,
                                                                             ease:"Cubic.easeOut"});
                TweenLite.to( $(gnbBtnArr[i]).find(".gnb_bullet_on img"), 0.65, {top:-12, left:-12, ease:"Cubic.easeOut"});
                TweenLite.to( $(gnbBtnArr[i]).find(".gnb_txt"), 0.65, {opacity:0.45, ease:"Cubic.easeOut"});
            }
        }
    }
}
//티켓모션
function gnbticketplay(){
    $(".topMenu .ticket .linelight_y1").css({opacity:0, left:0, top:10});
    $(".topMenu .ticket .linelight_y2").css({opacity:0, left:156, top:0});
    
    $(".topMenu .ticket .linelight1").css({opacity:0, left:0});
    TweenLite.to( $(".topMenu .ticket .linelight1"), 1.2, {left:77, opacity:1, ease:"Sine.easeOut", onComplete:ticketmovcomplete});
    
    $(".topMenu .ticket .linelight2").css({opacity:0, left:77});
    TweenLite.to( $(".topMenu .ticket .linelight2"), 1.2, {left:0, opacity:1, ease:"Sine.easeOut", onComplete:ticketmovcomplete});
    
    
    $(".topMenu .ticket .linelight_y1").css({opacity:0, left:0, top:10});
    TweenLite.to( $(".topMenu .ticket .linelight_y1"), 1.2, {left:0, top:0, opacity:1});
    
    $(".topMenu .ticket .linelight_y2").css({opacity:0, left:156, top:0});
    TweenLite.to( $(".topMenu .ticket .linelight_y2"), 1.2, {left:156, top:10, opacity:1});
    
}
function ticketmovcomplete(){
    
    TweenLite.to( $(".topMenu .ticket .linelight1"), 1.2, {left:82, opacity:0, ease:"Sine.easeOut"});
    TweenLite.to( $(".topMenu .ticket .linelight2"), 1.2, {left:-5, opacity:0, ease:"Sine.easeOut"});
    
    TweenLite.to( $(".topMenu .ticket .linelight_y1"), 1.0, {left:0, top:-10, opacity:0, ease:"Sine.easeIn", onComplete:gnbticketplay});
    TweenLite.to( $(".topMenu .ticket .linelight_y2"), 1.0, {left:156,  top:30, opacity:0, ease:"Sine.easeIn", onComplete:gnbticketplay});
}

//가운데 불꽃사진공모전 버튼
function btnphotoHandler(e){
    switch(e.type)
    {
        case "mouseenter" :
            TweenLite.to($(".firecon .fireover"), .5, {opacity:.5})
            break;
        case "mouseleave" :
            TweenLite.to($(".firecon .fireover"), .5, {opacity:0})
            break;
        case "click" :
            checkTrack("Main_F gallery");
            break;    
    }
}

//가운데 불꽃티켓
function btnTicketHandler2(e){
    switch(e.type)
    {
        case "mouseenter" : 
            TweenLite.to( $(".firecon .ticket .linelight1"), 0.4, {left:135, ease:"Expo.easeOut"});
            TweenLite.to( $(".firecon .ticket .linelight2"), 0.4, {left:95, ease:"Expo.easeOut"});
            break;
        case "mouseleave" : 
            TweenLite.to( $(".firecon .ticket .linelight1"), 0.4, {left:95, ease:"Sine.easeOut"});
            TweenLite.to( $(".firecon .ticket .linelight2"), 0.4, {left:135, ease:"Sine.easeOut"});
            break;
        case "click" :
            checkTrack("Main_F Ticket");
            break;
    }
}
//gnb불꽃티켓
function btnTicketHandler(e){
    switch(e.type)
    {
        case "mouseenter" : 
            TweenLite.to( $(".topMenu .ticket .linelight1"), 0.4, {left:40, ease:"Expo.easeOut"});
            TweenLite.to( $(".topMenu .ticket .linelight2"), 0.4, {left:0, ease:"Expo.easeOut"});
            break;
        case "mouseleave" :
            TweenLite.to( $(".topMenu .ticket .linelight1"), 0.4, {left:0, ease:"Sine.easeOut"});
            TweenLite.to( $(".topMenu .ticket .linelight2"), 0.4, {left:40, ease:"Sine.easeOut"});
            break;
            
        case "click" :
//            checkTrack("ticket_gnb");
            checkTrack("gallery_gnb");
            break;
    }
}

//init
function init(){
    $(".bg").css({top:0})
    $(".line").css({top:0+ _hct})
    $("section").css({top:0});
    
    //인트로 위한 알파0
    $(".starcon").css("opacity", "0")
    $(".line").css("opacity", "0")
    
    //폭죽셋팅
    firesetting();
    
    //라인셋팅
    for(var i=1; i<5; i++){
        linesetting(i);
    }
}

//파라미터 함수
function Request(){
    this.getParameter = function( name )
    {
        var rtnval = '';
        var nowAddress = unescape(location.href);
        var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');

        for(var i = 0 ; i < parameters.length ; i++)
        {
            var varName = parameters[i].split('=')[0];
            if(varName.toUpperCase() == name.toUpperCase())
            {
                rtnval = parameters[i].split('=')[1];
                break;
            }
        }
        return rtnval;
    }
}

//이벤트 셋팅
function initEventListener(){
    stageResize();
    $(window).bind("resize", stageResize);
    $("html").bind("mousewheel", mouseWheelHandler);  
    $("body").bind("keyup", keyHandler);
}
var btnName;
//Gnb 셋팅
function initGnb(){
    //GNB 클릭
    $(".header .gnb li a").click(function(e){
        if(flag){
//            e.preventDefault();
//            $(".now").removeClass("now");
            var old = index;
//            index = $(".header .gnb li").index(this);
            index = $(".header .gnb li").index($(this).parent('li'));
            
            var result = old-index;
            if(result<1){
                chknum = 0;
            }else if(result>1){
                chknum = 1;
            }
            
            //offsetVal 값 
            offsetVal = $('.content section').eq(index).offset().top;
            offsetTop();
//            console.log("GNB   메뉴 : ", index, "offsetVal : ", offsetVal);
//            console.log("index값 : ", index , "currentindex : ", currentindex);


            /*   기존
            if(currentindex == index+1) return; //같은 메뉴 눌렀을때
            $(".starcon .star").first().remove();
            sectionMov(index+1, chknum);
            */
            
            if(currentindex == index+1){
                return; //같은 메뉴 눌렀을때
            }else{
                $(".starcon .star").first().remove();
                var actionId = "";
                switch(index){
                    case 0: 
                        actionId = "index"; 
                        btnName = "GO-MAIN" //메인으로
                        break;
                    case 1: 
                        actionId = "guide";
                        btnName = "Guide_gnb" //축제안내
                        break;
                    case 2: 
                        actionId = "information"; 
                        btnName = "info_gnb" //불꽃정보
                        break;
                    case 3: 
                        actionId = "safeguide"; 
                        btnName = "safe_gnb" //안전지침
                        break;
                    case 4: 
                        actionId = "center"; 
                        btnName = "notic_gnb" //운영센터
                        break;
                }
                /*
                NetFunnel_Action({
                    service_id : "service_1",
                    action_id : actionId
                },
                function(){
                    checkTrack(btnName);
                    sectionMov(index+1, chknum);
                });
                */
                checkTrack(btnName);
                sectionMov(index+1, chknum);
            }
        }
        
        return false;
    });

	// 스크롤다운 클릭
    $(".content .con .main .section1 .scrolldown").click(function(e){
        e.preventDefault();
        sectionMov(2, 0);
    });
    
    // 스크롤업 클릭
    $(".content .con .main .section6 .scrollup").click(function(e){
        e.preventDefault();
        sectionMov(1, 3);
    });
}
function gnbbottom_on(){
    $(".header").css({top:_height + 75});
    TweenLite.to($(".header"), 1.0, { top:_height-75, ease:Sine.easeOut });
         
}
function gnbbottom_off(){
    $(".header").css({top:_height-75})
    TweenLite.to($(".header"), 1.0, { top:_height+75, ease:Sine.easeOut, onComplete:gnbtop_on });
}
function gnbtop_on(){
    if(gnbflag == true){
        gnbflag = false;
        $(".header").css({top:-100})
        TweenLite.to($(".header"), 1.0, { top:0, ease:Sine.easeOut });
    }
}

function gnbtop_off(){
    $(".header").css({top:0})
    TweenLite.to($(".header"), 1.0, { top:-100, ease:Sine.easeOut, onComplete:gnbbottom_on });
}
function gnb_stop(){
    $(".header").css({top:0})
}

//스크롤 스타트
function startScroll(){
    $("html").bind("mousewheel", mouseWheelHandler); 
    $("body").bind("keyup", keyHandler);
}
//스크롤다운모션
function scrolldownmotion(){
    $(".scrolldown .ww2").css({top:50, opacity:.5})
    TweenLite.to($(".scrolldown .ww1"), .9, {  top:50, opacity:0, ease:Sine.easeOut, onComplete:downcomplete });
}
function downcomplete(){
    $(".scrolldown .ww1").css({top:44, opacity:.7})
    TweenLite.to($(".scrolldown .ww2"), .6, {  top:58, opacity:0, ease:Sine.easeOut });
    scrolldownmotion();
}

//스크롤업모션
function scrollupmotion(){
    $(".scrollup .ww2").css({top:0, opacity:.5})
    TweenLite.to($(".scrollup .ww1"), .9, {  top:0, opacity:0, ease:Sine.easeOut, onComplete:upcomplete });
}
function upcomplete(){
    $(".scrollup .ww1").css({top:6, opacity:.7})
    TweenLite.to($(".scrollup .ww2"), .6, {  top:-6, opacity:0, ease:Sine.easeOut });
    scrollupmotion();
}

var movplayfun;
//section complete (화면 이동 완료)
function sectionComplete(idx, chk){
    $("html").bind("mousewheel", mouseWheelHandler);  
    $("body").bind("keyup", keyHandler);
    
    flag = true;
    index = idx;
    
    $(".f1").css("opacity","0");
    $(".f2").css("opacity","0");
//      movPlay(index);
    clearTimeout(movplayfun);
    movplayfun = setTimeout(function(){ movPlay(index);},1500);
    
    chknum = chk;
    currentindex = idx;
    
//    console.log(" ===================== 화면 이동 완료 : ", idx , " ========================= index  : ", index, "_____chknum :", chknum , "  ++++ currentindex : ", currentindex);
}

var t1;
var t2;
var t3;
var t4;
var t5;
var t6;


function movPlay(idx){
    
    $(".f1").css("opacity","0");
    $(".f2").css("opacity","0");
    $(".section1 .f1 img").css({width:996, height:1139, marginRight:50, marginTop:50, opacity:0});
    $(".section1 .f2 img").css({width:421, height:432, marginLeft:50, marginTop:50, opacity:0});
    
    $(".section2 .f1 img").css({width:557, height:550, marginLeft:50, marginTop:50, opacity:0});
    $(".section3 .f1 img").css({width:545, height:570, marginRight:50, marginTop:50, opacity:0});
    $(".section4 .f1 img").css({width:489, height:432, marginLeft:50, marginTop:50, opacity:0});
    $(".section5 .f1 img").css({width:628, height:496, marginRight:50, marginTop:50, opacity:0});
    
    if(idx == 1){
        //메인 등장모션
        TweenLite.to(".section1 .firecon", 1.8, { delay:1.0, opacity:1 , ease:Sine.easeOut });
        
        if(_height <= 770){
            TweenLite.to(".section1 h1", 2.4, { top:208, opacity:1 , ease:Sine.easeOut });
            TweenLite.to(".section1 .date", 1.4, { delay:.8, top:595, opacity:1 , ease:Sine.easeOut });
            TweenLite.to(".section1 .scrolldown", 2.0, {delay:1.2, top:670,  opacity:1 , ease:Sine.easeOut });
            
        }else if(_height > 770 && _height < 880){
            TweenLite.to(".section1 h1", 2.4, { top:188,opacity:1 , ease:Sine.easeOut });
            TweenLite.to(".section1 .date", 1.4, { delay:.8,top:615, opacity:1 ,ease:Sine.easeOut });
            TweenLite.to(".section1 .scrolldown", 2.0, { delay:1.2, top:720,  opacity:1 , ease:Sine.easeOut });
            
        }else if(_height >= 880){
            TweenLite.to(".section1 h1", 2.4, { top:168, opacity:1 ,ease:Sine.easeOut });
            TweenLite.to(".section1 .date", 1.4, { delay:.8, top:655,  opacity:1 ,ease:Sine.easeOut });
            TweenLite.to(".section1 .scrolldown", 2.0, {delay:1.2, top:780,  opacity:1 , ease:Sine.easeOut });
        }
        if(chknum == 0){
            
            t1 = setTimeout(function(){ firePlay(1);},200);
        }else{
            t1 = setTimeout(function(){ firePlay(1);},2000);
        }
        
    }else if(idx == 2){
        t2 = setTimeout(function(){ firePlay(2);},150);
    }else if(idx == 3){
        t3 = setTimeout(function(){ firePlay(3);},150);
    }else if(idx == 4){
        t4 = setTimeout(function(){ firePlay(4);},150);
    }else if(idx == 5){
        t5 = setTimeout(function(){ firePlay(5);},150);
    }else if(idx == 6){
        if(_height >870){
            t6 = setTimeout(function(){ firePlay(6);},150);
        }else{
            t6 = setTimeout(function(){ firePlay(6);},150); 
        }
    }  
}

function fireDelete(){
    
    clearInterval(myVar1);
    clearInterval(myVar2);
    clearInterval(myVar3);
    clearInterval(myVar4);
    clearInterval(myVar5);
    clearInterval(myVar6);
    clearTimeout(t1);
    clearTimeout(t2);
    clearTimeout(t3);
    clearTimeout(t4);
    clearTimeout(t5);
    clearTimeout(t6);
    
    clearTimeout(sm1)
    clearTimeout(sm2)
    clearTimeout(sm3)
    clearTimeout(sm4)
    clearTimeout(sm5)
    clearTimeout(sm6)
    clearTimeout(sm7)
    clearTimeout(sm8)
    clearTimeout(sm9)
    clearTimeout(sm10)
    clearTimeout(sm11)
    
    clearTimeout(line1)
    clearTimeout(line2)
    clearTimeout(line3)
    clearTimeout(line4)
    
   $(".ftype1 img").css({opacity:0})
   $(".ftype2 img").css({opacity:0})
   $(".ftype3 img").css({opacity:0})
}

var sm1;
var sm2;
var sm3;
var sm4;
var sm5;
var sm6;
var sm7;
var sm8;
var sm9;
var sm10;
var sm11;

var line_oldindex1;
var line_index1;
var line_oldindex2;
var line_index2;
var line_oldindex3;
var line_index3;
var lineVar1;
var lineVar2;
var lineVar3;
var line1;
var line2;
var line3;
var line4;
var line5;

//폭죽
function firePlay(idx){
    $(".linedown").css({display:"block", opacity:1});
    $(".lineup").css({display:"block", opacity:1});
    //폭죽랜덤
    if(idx == 1){
        
        settingMotion(1,1);
        clearTimeout(sm1);
        sm1 = setTimeout(function(){ settingMotion(2,1);},600);
        $(".section1 .f1").css({ opacity:1 });
        $(".section1 .f2").css({ opacity:1 });
        $(".section1 .f1 img").stop().delay(1500).animate({ width:1096,height:1239,"margin-right":0, "margin-top":0, opacity:1 }, 1800, "easeOutSine");
        $(".section1 .f2 img").stop().delay(800).animate({ width:521,height:532,"margin-left":0, "margin-top":0, opacity:1 }, 1400, "easeOutSine");
    }else if(idx == 2){
        
        settingMotion(3,2);
        clearTimeout(sm2);
        clearTimeout(sm3);
        sm2 = setTimeout(function(){ settingMotion(4, 2);},400);
        sm3 = setTimeout(function(){ settingMotion(5, 2);},600);
        $(".section2 .f1").css({ opacity:1 });
        $(".section2 .f1 img").stop().delay(1100).animate({ width:657,height:650,"margin-left":0, "margin-top":0, opacity:1 }, 2000, "easeOutSine");
        clearTimeout(line1);
        line1 = setTimeout(function(){ lineMotion(chknum, 2);},1000); //( 위아래방향체크, section넘버)
        
    }else if(idx == 3){
        
        settingMotion(1,3);
        clearTimeout(sm4);
        clearTimeout(sm5);
        sm4 = setTimeout(function(){ settingMotion(4, 3);},400);
        sm5 = setTimeout(function(){ settingMotion(5, 3);},600);
        $(".section3 .f1").css({ opacity:1 });
        $(".section3 .f1 img").stop().delay(1100).animate({ width:645,height:670,"margin-right":0, "margin-top":0, opacity:1 }, 2000, "easeOutSine");
        clearTimeout(line2);
        line2 = setTimeout(function(){ lineMotion(chknum, 3);},1000); //( 위아래방향체크, section넘버)
        
    }else if(idx == 4){
        
        settingMotion(1,4);
        clearTimeout(sm6);
        clearTimeout(sm7);
        sm6 = setTimeout(function(){ settingMotion(4, 4);},400);
        sm7 = setTimeout(function(){ settingMotion(5, 4);},600);
        $(".section4 .f1").css({ opacity:1 });
        $(".section4 .f1 img").stop().delay(1100).animate({ width:589,height:532,"margin-left":0, "margin-top":0, opacity:1 }, 2000, "easeOutSine");
        clearTimeout(line3);
        line3 = setTimeout(function(){ lineMotion(chknum, 4);},1000); //( 위아래방향체크, section넘버)
        
    }else if(idx == 5){
        
        settingMotion(1,5);
        clearTimeout(sm8);
        clearTimeout(sm9);
        sm8 = setTimeout(function(){ settingMotion(4, 5);},400);
        sm9 = setTimeout(function(){ settingMotion(5, 5);},600);
        $(".section5 .f1").css({ opacity:1 });
        $(".section5 .f1 img").stop().delay(1100).animate({ width:728,height:596,"margin-right":0, "margin-top":0, opacity:1 }, 2000, "easeOutSine");
        clearTimeout(line4);
        line4 = setTimeout(function(){ lineMotion(chknum, 5);},1000); //( 위아래방향체크, section넘버)
        
    }else if(idx == 6){
        clearTimeout(line5);
        line5 = setTimeout(function(){ lineMotion6();},600);
    }
}

function lineMotion(chk, snum){
   
    if(chk == 0){ //section 넘버
        line_oldindex1 = 0;
        line_index1 = 0;
        clearInterval(lineVar1);
        lineVar1 = setInterval(function(){lineTimer_down(snum);},60);
    }else if(chk == 1){ //section 넘버
        line_oldindex2 = 0;
        line_index2 = 0;
        clearInterval(lineVar2);
        lineVar2 = setInterval(function(){lineTimer_up(snum);},60);
    }
}

function lineMotion6(){
    
    line_oldindex3 = 0;
    line_index3 = 0;
    clearInterval(lineVar3);
    lineVar3 = setInterval(function(){lineTimer_down6();},60);
}

function settingMotion(idx, snum){
   $(".ftype1 img").css({opacity:0})
   $(".ftype2 img").css({opacity:0})
   $(".ftype3 img").css({opacity:0})
    if(idx == 1){
        oldindex1 = 0;
        index1 = 0;
        clearInterval(myVar1);
        myVar1 = setInterval(function(){aniTimer1(snum);},60); //28 ftype1
    }else if(idx == 2){
        oldindex2 = 0;
        index2 = 0;
        clearInterval(myVar2);
        myVar2 = setInterval(function(){aniTimer2(snum);},60); //24 ftype2
    }else if(idx == 3){
        oldindex3 = 0;
        index3 = 0;
        clearInterval(myVar3);
        myVar3 = setInterval(function(){aniTimer3(snum);},60); //13 ftype1
    }else if(idx == 4){
        oldindex4 = 0;
        index4 = 0;
        clearInterval(myVar4);
        myVar4 = setInterval(function(){aniTimer4(snum);},60);//19 ftype2
    }else if(idx == 5){ 
        oldindex5 = 0;
        index5 = 0;
        clearInterval(myVar5);
        myVar5 = setInterval(function(){aniTimer5(snum);},60); //28 ftype3
    }else if(idx == 6){ 
        oldindex6 = 0;
        index6 = 0;
        clearInterval(myVar6);
        myVar6 = setInterval(function(){aniTimer6(snum);},60); //28 ftype3 
    }
}

function settingMotion2(idx, snum){
   $(".ftype1 img").css({opacity:0})
   $(".ftype2 img").css({opacity:0})
   $(".ftype3 img").css({opacity:0})
   
   if(idx == 1){   
        oldindex1 = 0;
        index1 = 0;
        clearInterval(myVar1);
        myVar1 = setInterval(function(){aniTimer1_s(snum);},60); //28 ftype1
    }else if(idx == 2){
        oldindex2 = 0;
        index2 = 0;
        clearInterval(myVar2);
        myVar2 = setInterval(function(){aniTimer2_s(snum);},60); //24 ftype2
    }else if(idx == 3){
        oldindex3 = 0;
        index3 = 0;
        clearInterval(myVar3);
        myVar3 = setInterval(function(){aniTimer3_s(snum);},60); //13 ftype1
    }
}


function lineTimer_down(snum){
    line_oldindex1 =0;
    line_oldindex1 = line_index1;
    if(line_index1==61) return;
    ++line_index1;
    $(".section"+snum+" .linedown img").eq(line_index1).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .linedown img").eq(line_oldindex1).css({opacity:0});
    });
    
    if(line_index1==61) {
        window.setTimeout(function(){$(".section"+snum+" .linedown img").eq(line_index1-1).css({opacity:0})},20);
        clearInterval(lineVar1);
    }
};

function lineTimer_up(snum){
    line_oldindex2 =0;
    line_oldindex2 = line_index2;
    if(line_index2==61) return;
    ++line_index2;
    $(".section"+snum+" .lineup img").eq(line_index2).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .lineup img").eq(line_oldindex2).css({opacity:0});
    });
    
    if(line_index2==61) {
        window.setTimeout(function(){$(".section"+snum+" .lineup img").eq(line_index2-1).css({opacity:0})},20);
        clearInterval(lineVar2);
    }
};
//6폭죽
function lineTimer_down6(){
    line_oldindex3 = 0;
    line_oldindex3 = line_index3;
    if(line_index3==35) return;
    ++line_index3;
    $(".section6 .linedown img").eq(line_index3).stop().animate({opacity:1},20, function(){
        $(".section6 .linedown img").eq(line_oldindex3).css({opacity:0});
    });
    
    if(line_index3==35) {
        window.setTimeout(function(){$(".section6 .linedown img").eq(line_index3-1).css({opacity:0})},20);
        clearInterval(lineVar1);
        
        settingMotion2(1,6);
        sm10 = setTimeout(function(){ settingMotion2(2, 6);},400);
        sm11 = setTimeout(function(){ settingMotion2(3, 6);},600);
    }
};


function aniTimer1(snum){
    oldindex1 = index1;
    if(index1==28) return;
    ++index1;
    $(".section"+snum+" .ftype1 img").eq(index1).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype1 img").eq(oldindex1).css({opacity:0});
    });
    
    if(index1==28) {
        window.setTimeout(function(){$(".section"+snum+" .ftype1 img").eq(index1-1).css({opacity:0})},20);
        clearInterval(myVar1);
    }
};
function aniTimer2(snum){
    oldindex2 = index2;
    if(index2==24) return;
    ++index2;
    $(".section"+snum+" .ftype2 img").eq(index2).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype2 img").eq(oldindex2).css({opacity:0});
    });
    
    if(index2==24) {
        window.setTimeout(function(){$(".section"+snum+" .ftype2 img").eq(index2-1).css({opacity:0})},20);
        clearInterval(myVar2);
    }
};
function aniTimer3(snum){
    
    oldindex3 = index3;
    if(index3==13) return;
    ++index3;
    $(".section"+snum+" .ftype1 img").eq(index3).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype1 img").eq(oldindex3).css({opacity:0});
    });
    
    if(index3==13) {
        window.setTimeout(function(){$(".section"+snum+" .ftype2 img").eq(index3-1).css({opacity:0})},20);
        clearInterval(myVar3);
    }
};
function aniTimer4(snum){
    
    oldindex4 = index4;
    if(index4==19) return;
    ++index4;
    $(".section"+snum+" .ftype2 img").eq(index4).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype2 img").eq(oldindex4).css({opacity:0});
    });
    
    if(index4==19) {
        window.setTimeout(function(){$(".section"+snum+" .ftype2 img").eq(index4-1).css({opacity:0})},20);
        clearInterval(myVar4);
    }
};
function aniTimer5(snum){
    
    oldindex5 = index5;
    if(index5==28) return;
    ++index5;
    $(".section"+snum+" .ftype3 img").eq(index5).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype3 img").eq(oldindex5).css({opacity:0});
    });
    
    if(index5==28) {
        window.setTimeout(function(){$(".section"+snum+" .ftype3 img").eq(index5-1).css({opacity:0})},20);
        clearInterval(myVar5);
    }
};
function aniTimer6(snum){
    oldindex6 = index6;
    if(index6==28) return;
    ++index6;
    $(".section"+snum+" .ftype3 img").eq(index6).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype3 img").eq(oldindex6).css({opacity:0});
    });
    
    if(index6==28) {
        window.setTimeout(function(){$(".section"+snum+" .ftype3 img").eq(index6-1).css({opacity:0})},20);
        clearInterval(myVar6);
    }
};

//small폭죽
function aniTimer1_s(snum){
    oldindex1 = index1;
    if(index1==24) return;
    ++index1;
    $(".section"+snum+" .ftype1 img").eq(index1).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype1 img").eq(oldindex1).css({opacity:0});
    });
    
    if(index1==24) {
        window.setTimeout(function(){$(".section"+snum+" .ftype1 img").eq(index6-1).css({opacity:0})},20);
        clearInterval(myVar1);
    }
};

function aniTimer2_s(snum){
    oldindex2 = index2;
    if(index2==28) return;
    ++index2;
    $(".section"+snum+" .ftype2 img").eq(index2).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype2 img").eq(oldindex2).css({opacity:0});
    });
    
    if(index2==28) {
        window.setTimeout(function(){$(".section"+snum+" .ftype2 img").eq(index2-1).css({opacity:0})},20);
        clearInterval(myVar2);
    }
};

function aniTimer3_s(snum){
    oldindex3 = index3;
    if(index3==16) return;
    ++index3;
    $(".section"+snum+" .ftype3 img").eq(index3).stop().animate({opacity:1},20, function(){
        $(".section"+snum+" .ftype3 img").eq(oldindex3).css({opacity:0});
    });
    
    if(index3==16) {
        window.setTimeout(function(){$(".section"+snum+" .ftype3 img").eq(index2-1).css({opacity:0})},20);
        clearInterval(myVar3);
    }
};

//키보드 핸들러
function keyHandler(e){
    e.preventDefault();
    var key = e.keyCode;
    if(key == 38){
        // up
        sectionMoveUpDown(false);
        
    }else if(key == 40){
        // down
        sectionMoveUpDown(true);
    }
}

//마우스휠 핸들러
function mouseWheelHandler(e){
    if(isSectionMoving) return;
    e.preventDefault();
    
    if(e.deltaY < 0){
        // down
        sectionMoveUpDown(true);
        
    }else if(e.deltaY > 0){
        // up
        sectionMoveUpDown(false);
    } 
}

function sectionMoveUpDown(isDown) {
    if(onSubLayer) return;
    
    var _count;
    var chknum;
    if(isDown){
        // down
        chknum = 0;
        _count = index + 1;
        if(_count == 7) return;
    }else{
        // up
        chknum = 1;
        _count = index - 1;
        if(_count == 0) return;
    }
    
    $(".starcon .star").first().remove();
    sectionMov(_count, chknum);
}

//offsetTop 셋팅
function offsetTop(){
    for( var i=0; i<6; i++){
        $(".con .section"+(i+1)).css({height:_reconheight });
        offsetHeight[i] = $(".con .section" + (i+1) ).offset().top;
    }
}
//section 이동 (화면 이동)
var isSectionMoving = false;
function sectionMov(idx , chk) {
//    console.log("sectionMov", idx, chk);
//    stageResize();
    if(isSectionMoving) return;
    isSectionMoving = true;
    setTimeout(function() {
        isSectionMoving = false;
        
        // 섹션이동후 포커스 지정
        $(".section"+idx).find('a').first().focus();
    }, 1000);
    
    index = idx;
    pictostop(1);
    pictostop(2);
    pictostop(3);
    fireDelete();
    
    $(".linedown").css({display:"none"});
    $(".lineup").css({display:"none"});
   
    $("html").unbind("mousewheel", mouseWheelHandler);
    $("body").unbind("keyup", keyHandler);
    
    currentMenuNum = idx-1;
    activationGNBMenu(idx-1);
    _reconheight = Math.floor($(".con .bg img").height()/6);
    _hct = Math.floor(_height - _reconheight )/2;
    
    chknum = chk;
    
//    $('.section'+ (currentMenuNum+1) +' .stitle').focus();
    
    //별추가
     $(".starcon").append( "<div class='star'><div class ='star1'><img src='http://cdn.hanwhafireworks.com/web/images/main/star1.png' alt='' /></div><div class ='star2'><img src='http://cdn.hanwhafireworks.com/web/images/main/star2.png' alt='' /></div></div>" );
    if ( idx == 1 ) {
        checkTrack("Main");
        //스크롤모션
        scrolldownmotion();
        
        introChk = false;
        $(".flvwrap").empty().html('<div class = "fire" id ="EvtFlashBox"></div>')
        flashVerChk();   
        
        gnbflag = true;
        parm = false;
        if(gnbflag == false){
            gnbtop_off();
        }else{
            gnbbottom_on();
        }
        
        $(".starcon").css({top:0, opacity:1});
            
        if(chknum == 0){//마우스휠 올리는거
            $(".starcon").css({top:0, opacity:1})
            TweenLite.to(".starcon", 2.0, { top:-980 , ease:Sine.easeOut });
            
            TweenLite.to(".bg", 1.4, {top:0 , ease:Sine.easeOut});
            sectionComplete(idx,chk)
            TweenLite.to(".line", 2.5, { top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to("section", 1.8, { top:0+_hct, ease:Sine.easeOut });
        }else if(chknum == 1){//마우스휠 내리는거
            //첫화면에서 폭죽나오기 전에 마우스휠 unbind
            $("html").unbind("mousewheel", mouseWheelHandler);  
            $("body").unbind("keyup", keyHandler);
            $(".starcon").css({top:-200, opacity:1})
//            TweenLite.to(".starcon", 2.0, { top:0 , ease:Sine.easeOut, onComplete:startScroll });
            TweenLite.to(".starcon", 2.0, { top:0 , ease:Sine.easeOut });
            
            TweenLite.to(".bg", 1.4, {top:0 , ease:Sine.easeOut});
            sectionComplete(idx,chk)
            TweenLite.to(".line", 2.5, { top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to("section", 1.8, { top:0+_hct, ease:Sine.easeOut });
            
        }else if(chknum == 2){
            //인트로 넘어와서 첫장면만 스톱
            $(".starcon").css({top:0,scaleX:.8, scaleY:.8, opacity:0})
            TweenLite.to(".starcon", 2.0, {delay:.1, top:0 , scaleX:1, scaleY:1, opacity:1,  ease:Sine.easeOut });
            
            TweenLite.to(".bg", 1.4, {top:0 , ease:Sine.easeOut});
            sectionComplete(idx,chk)
            TweenLite.to(".line", 2.5, { top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to("section", 1.8, { top:0+_hct, ease:Sine.easeOut });
            $("#spin").hide();
            
        }else if(chknum == 3){
            //풋터에서 스크롤버튼 눌렀을때 느리게 올라가기
            $(".starcon").css({top:0,scaleX:.8, scaleY:.8, opacity:0})
            TweenLite.to(".starcon", 2.0, {delay:.1, top:0 , scaleX:1, scaleY:1, opacity:1,  ease:Sine.easeOut });
            
            TweenLite.to(".bg", 3.6, {top:0 , ease:Sine.easeOut});
            sectionComplete(idx,chk)
            TweenLite.to(".line", 5.0, { top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to("section", 4.0, { top:0+_hct, ease:Sine.easeOut });
        }
        
    } else if( idx > 1 && idx < 7 ){
        scrolldownmotion();
        $(".flvwrap").empty().html('<div class = "fire" id ="EvtFlashBox"></div>')
        introChk = false
//        gnbflag = true;
//        parm = false;
        if(gnbflag == false){
            gnbtop_on();
        }else{
//          gnbbottom_off();
            
            if(parm == true){
                gnb_stop();
            }else{
                
                if(chknum == 2){
                    gnb_stop();
                }else{
                    gnbbottom_off();
                }
            }
        }
        
        if(idx == 6){
            
            scrollupmotion();
            
            $(".bottombg").css("display","block");
            if(_height < 770){
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + _mt+(-_hct*(-.8))) , ease:Sine.easeOut });
                sectionComplete(idx,chk);
//                TweenLite.to($(".section6 .stitle2"), .5,{opacity:0,top: 280, ease:Sine.easeOut})
                TweenLite.to($(".navi"), 1.8, {top: 610-60, ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830-110, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870-110, ease:Sine.easeOut });
                
            }else{
//                TweenLite.to($(".section6 .stitle2"), 1.8, {top: 280-40, ease:Sine.easeOut  });
                
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + (_hct*2) ) , ease:Sine.easeOut });
                sectionComplete(idx,chk);
                TweenLite.to($(".navi"), 1.8, {top: 630+(_hct), ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830+(_hct)+20, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870+(_hct)+20, ease:Sine.easeOut });
            }
            
            TweenLite.to(".line", 2.5, { top:Math.floor(-_reconheight*(idx-1)) + _hct ,ease:Sine.easeOut });
            TweenLite.to("section", 1.8, { top:Math.floor(-_reconheight*(idx-1)) + _hct ,ease:Sine.easeOut });
           
            if(chknum == 0){
                $(".starcon").css({top:0})
                TweenLite.to(".starcon", 2.0, { top:-980 , opacity:0, ease:Sine.easeOut });
            }else if(chknum == 1){
                 $(".starcon").css({top:-980})
                 TweenLite.to(".starcon", 2.0, { top:0 , opacity:0, ease:Sine.easeOut });  
                
                
            }
            TweenLite.to(".star1", 3.5, { top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to(".star2", 2.5, { top:0 + _hct, ease:Sine.easeOut });
            
            if(_height < 770){
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + _mt+(-_hct*(-.4))) , ease:Sine.easeOut });
                TweenLite.to($(".line"), 2.5, {top: Math.floor((-_reconheight*(idx-1)) + _mt) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top: Math.floor((-_reconheight*(idx-1)) + _mt) , ease:Sine.easeOut });

                TweenLite.to($(".section6 .stitle2"), .5,{opacity:0,top: 220, ease:Sine.easeOut})
                TweenLite.to($(".navi"), 1.8, {top: 610-60, ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830-110, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870-110, ease:Sine.easeOut });    
            }else if(_height >= 770 && _height < 880){
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + (_hct*2) ) , ease:Sine.easeOut });
                TweenLite.to($(".section6 .stitle2"), 1.8, {top: 220,opacity:1, ease:Sine.easeOut  });
                TweenLite.to($(".navi"), 1.8, {top: 630+ _hct , ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830+ _hct+20, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870+ _hct+20, ease:Sine.easeOut });
                
                TweenLite.to($(".line"), 1.0, {top:Math.floor((-_reconheight*(idx-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + _hct ) , ease:Sine.easeOut });
            }else if(_height >= 880){
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + (_hct*2) ) , ease:Sine.easeOut });
                TweenLite.to($(".section6 .stitle2"), 1.8, {top: 280,opacity:1, ease:Sine.easeOut  });
                TweenLite.to($(".navi"), 1.8, {top: 630+ _hct , ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830+ _hct+20, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870+ _hct+20, ease:Sine.easeOut });
                
                TweenLite.to($(".line"), 1.0, {top:Math.floor((-_reconheight*(idx-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(idx-1)) + _hct ) , ease:Sine.easeOut });
            }
            
        }else{
            
            if(_height > 770){
                TweenLite.to($(".stitle"), 2.0, { top:250, ease:Sine.easeOut });
                TweenLite.to($(".stitle .st2"), 2.0, { top:0, ease:Sine.easeOut });
                TweenLite.to($(".pictobox"), 2.0, { top:280, ease:Sine.easeOut });
                TweenLite.to($(".boxover"), 2.0, { top:280, ease:Sine.easeOut });
                
            }else{
                TweenLite.to($(".stitle"), 2.0, { top:280, ease:Sine.easeOut });
                TweenLite.to($(".stitle .st2"), 2.0, { top:-20, ease:Sine.easeOut });
                TweenLite.to($(".pictobox"), 2.0, { top:250, ease:Sine.easeOut });
                TweenLite.to($(".boxover"), 2.0, { top:250, ease:Sine.easeOut });
                
            }
            //스크롤 위치
            if(_height < 770){
                TweenLite.to(".section2 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                TweenLite.to(".section3 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                TweenLite.to(".section4 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                TweenLite.to(".section5 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
             }else if(_height >= 770 && _height < 880){
                TweenLite.to(".section2 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section3 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section4 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section5 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
             }else if(_height >= 880){
                TweenLite.to(".section2 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section3 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section4 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section5 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
             }
            
            if(pchk == false){
//                TweenLite.to(".bg", 1.8, {top:Math.floor(-_reconheight*(idx-1)) , ease:Sine.easeOut, onComplete:sectionComplete, onCompleteParams:[idx,chk] });
                TweenLite.to(".bg", 1.8, {top:Math.floor(-_reconheight*(idx-1)) , ease:Sine.easeOut });
                sectionComplete(idx,chk);
                TweenLite.to(".line", 2.5, { top:Math.floor(-_reconheight*(idx-1)) + _hct , ease:Sine.easeOut });
                TweenLite.to("section", 1.2, { top:Math.floor(-_reconheight*(idx-1)) + _hct , ease:Sine.easeOut });
                
            }else{
                //고정
                $(".bg").css({"top":Math.floor(-_reconheight*(idx-1)) + _hct});
                window.setTimeout(function(){sectionComplete(idx,chk)},1500);
                
                $(".line").css({"top":Math.floor(-_reconheight*(idx-1)) + _hct});
                $("section").css({"top":Math.floor(-_reconheight*(idx-1)) + _hct });
                 $(".starcon").css({top:0})
                pchk = false;
                
            }
            
            if(chknum == 0){ //마우스휠 down
                $(".starcon").css({top:0, opacity:1});
                $(".starcon .star1").css({top:400});
                $(".starcon .star2").css({top:100});
                TweenLite.to(".starcon", 2.0, { top:-980, ease:Sine.easeOut });
                
            }else if(chknum == 1){ //마우스휠 up
                
                if(pchk == false){
                    $(".starcon").css({top:-980, opacity:1});
                    $(".starcon .star1").css({top:-400});
                    $(".starcon .star2").css({top:-100});
                    TweenLite.to(".starcon", 2.0, { top:0 , ease:Sine.easeOut });
                   
                }else{
                    $(".starcon").css({top:0});
                    pchk = false;
                }
                
             }else if(chknum == 2){
                    //파라미터값 넘어갈때
                    $(".starcon").css({top:-200, opacity:1});
                    $(".starcon .star1").css({top:-400});
                    $(".starcon .star2").css({top:-100});
                    TweenLite.to(".starcon", 2.0, { top:0 , ease:Sine.easeOut });
            
            }else if(chknum == 3){
                    //스크롤다운버튼 누를때
                    $(".starcon").css({top:0, opacity:1});
                    $(".starcon .star1").css({top:400});
                    $(".starcon .star2").css({top:100});
                    TweenLite.to(".starcon", 2.0, { top:-980 , ease:Sine.easeOut });
            }
            
            TweenLite.to(".starcon .star1", 3.5, { top:0, ease:Sine.easeOut });
            TweenLite.to(".starcon .star2", 2.5, { top:0, ease:Sine.easeOut });
            
        }
    }else if ( idx == 0 ) {
        $(".bg").css({top:0});
    }
}

//리사이즈
function stageResize(){
    _width = $(window).width();
    _height = $(window).height();
    
    _reconheight = Math.floor($(".con .bg img").height()/6);
    _gb = _height - _reconheight;
    
    _hct = Math.floor(_height - _reconheight )/2; //위아래 여백값
    _mt = Math.floor(670 - _reconheight )/2; //minHeight 값
    
    // width 리사이즈
    halfpage = Math.floor($(".con").width() / 2);
    $(".con").css({left:halfpage-960});
    
    offsetTop();
    //인트로 resize
    TweenLite.to($(".intro"), 1.8, {top:0 + _hct, ease:Sine.easeOut });
    
    
    $(".bottombg").css({bottom:0});
//section 리사이즈
    if(_height > 770){
        TweenLite.to($(".stitle"), 2.0, { top:250, ease:Sine.easeOut });
        TweenLite.to($(".stitle .st2"), 2.0, { top:0, ease:Sine.easeOut });
        TweenLite.to($(".pictobox"), 2.0, { top:280, ease:Sine.easeOut });
        TweenLite.to($(".boxover"), 2.0, { top:280, ease:Sine.easeOut });
    }else{
        TweenLite.to($(".stitle"), 2.0, { top:280, ease:Sine.easeOut });
        TweenLite.to($(".stitle .st2"), 2.0, { top:-20, ease:Sine.easeOut });
        TweenLite.to($(".pictobox"), 2.0, { top:250, ease:Sine.easeOut });
        TweenLite.to($(".boxover"), 2.0, { top:250, ease:Sine.easeOut });
    }
    
    if(_height > 770 && _height < 880){
         if ( index == 1 ) {
            TweenLite.to($(".header"), 1.0, { top:_height-75, ease:Sine.easeOut });
            
            TweenLite.to($(".bg"), 1.8, {top:0 , ease:Sine.easeOut });
            TweenLite.to($(".line"), 2.5, {top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to($("section"), 1.8, {top:0 + _hct, ease:Sine.easeOut });
            
            TweenLite.to(".section1 h1", 2.4, { top:188,  ease:Sine.easeOut });
            TweenLite.to(".section1 .date", 1.4, { top:615,  ease:Sine.easeOut });
            TweenLite.to(".section1 .scrolldown", 2.0, { top:720 , ease:Sine.easeOut });
            
        } else if( index > 1 && index < 7 ){
            
            if(index == 6){
                
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + (_hct*2) ) , ease:Sine.easeOut });
                TweenLite.to($(".section6 .stitle2"), 1.8, {top: 220,opacity:1, ease:Sine.easeOut  });
                TweenLite.to($(".navi"), 1.8, {top: 630+ _hct , ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830+ _hct+20, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870+ _hct+20, ease:Sine.easeOut });
                
                TweenLite.to($(".line"), 1.0, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
            }else{
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($(".line"), 2.5, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(index-1))+ _hct ) , ease:Sine.easeOut });
                
                TweenLite.to(".section2 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section3 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section4 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
                TweenLite.to(".section5 .scrolldown", .8, { top:805 , ease:Sine.easeOut });
            }
        } 
        
    }else if(_height >= 880){
       
        if ( index == 1 ) {
            
            TweenLite.to($(".header"), 1.0, { top:_height-75, ease:Sine.easeOut });
            TweenLite.to($(".bg"), 1.8, {top:0 , ease:Sine.easeOut });
            TweenLite.to($(".line"), 2.5, {top:0 + _hct, ease:Sine.easeOut });
            TweenLite.to($("section"), 1.8, {top:0 + _hct, ease:Sine.easeOut });
            
            TweenLite.to(".section1 h1", 2.4, { top:168,  ease:Sine.easeOut });
            TweenLite.to(".section1 .date", 1.4, { top:655,  ease:Sine.easeOut });
            TweenLite.to(".section1 .scrolldown", 2.0, { top:780 , ease:Sine.easeOut });
            
        } else if( index > 1 && index < 7 ){
            
            if(index == 6){
                
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + (_hct*2) ) , ease:Sine.easeOut });
                TweenLite.to($(".section6 .stitle2"), 1.8, {top: 280,opacity:1, ease:Sine.easeOut  });
                TweenLite.to($(".navi"), 1.8, {top: 630+ _hct , ease:Sine.easeOut  });
                TweenLite.to($(".scrollup"), 1.8, {top: 830+ _hct+20, ease:Sine.easeOut });
                TweenLite.to($(".footermenu"), 1.8, {top: 870+ _hct+20, ease:Sine.easeOut });
                
                TweenLite.to($(".line"), 1.0, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
            }else{
                TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($(".line"), 2.5, {top:Math.floor((-_reconheight*(index-1)) + _hct ) , ease:Sine.easeOut });
                TweenLite.to($("section"), 1.8, {top:Math.floor((-_reconheight*(index-1))+ _hct ) , ease:Sine.easeOut });
                
                TweenLite.to(".section2 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section3 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section4 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
                TweenLite.to(".section5 .scrolldown", .8, { top:825 , ease:Sine.easeOut });
            }
        } 
       
    }else if(_height <= 770){
         
        if(introChk == true){
            $(".bg").css({top:0});
        }else{
            
          if(index == 1){
              TweenLite.to($(".header"), 1.0, { top:_height-75, ease:Sine.easeOut });
              
              TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
              TweenLite.to($(".line"), 2.5, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
              TweenLite.to($("section"), 1.8, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
              TweenLite.to(".section1 h1", 2.4, { top:208,  ease:Sine.easeOut });
              TweenLite.to(".section1 .date", 1.4, { top:595,  ease:Sine.easeOut });
              TweenLite.to(".section1 .scrolldown", 2.0, { top:670,  opacity:1 , ease:Sine.easeOut });
              
           } else if( index > 1 && index < 7 ){
               
               if(index == 6){
                    TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _mt+(-_hct*(-.4))) , ease:Sine.easeOut });
                    TweenLite.to($(".line"), 2.5, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
                    TweenLite.to($("section"), 1.8, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
                   
                    TweenLite.to($(".section6 .stitle2"), .5,{opacity:0,top: 220, ease:Sine.easeOut})
                    TweenLite.to($(".navi"), 1.8, {top: 610-60, ease:Sine.easeOut  });
                    TweenLite.to($(".scrollup"), 1.8, {top: 830-110, ease:Sine.easeOut });
                    TweenLite.to($(".footermenu"), 1.8, {top: 870-110, ease:Sine.easeOut });
                  
              }else{
                    TweenLite.to($(".bg"), 1.8, {top:Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
                    TweenLite.to($(".line"), 2.5, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
                    TweenLite.to($("section"), 1.8, {top: Math.floor((-_reconheight*(index-1)) + _mt) , ease:Sine.easeOut });
                    TweenLite.to(".section1 .scrolldown", 2.0, { top:720,  opacity:1 , ease:Sine.easeOut });
                  
                  TweenLite.to(".section2 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                  TweenLite.to(".section3 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                  TweenLite.to(".section4 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
                  TweenLite.to(".section5 .scrolldown", .8, { top:735 , ease:Sine.easeOut });
              }
           }
        }
    }
    
//    if(_width > 1920){
//        TweenLite.to($(".skipbtn"), .8, { bottom:110, right:(_width/2)-halfpage +100, opacity:1,ease:Sine.easeOut });
//    }else if(_width <= 1920){
//        TweenLite.to($(".skipbtn"), .8, { bottom:110, right:110, opacity:1,ease:Sine.easeOut });
//    }
}

function firesetting(){
    //1 폭죽 A
    for ( i=0; i <25; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section1 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_A/Type_A_000"+inum+".png' alt='' />");
    }
    
    //1 폭죽 B
    for ( i=0; i <28; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section1 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_B/Type_B_000"+inum+".png' alt='' />");
    }
    
    //2 폭죽 C
    for ( i=0; i <14; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section2 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_C/Type_C_000"+inum+".png' alt='' />");
    }
    //2 폭죽 D
    for ( i=0; i <20; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section2 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_D/Type_D_000"+inum+".png' alt='' />");
    }
    //2 폭죽 E
    for ( i=0; i <28; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section2 .ftype3").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_B/Type_B_000"+inum+".png' alt='' />");
    }
    
     //3 폭죽 F
    for ( i=0; i <24; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section3 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_F/Type_F_000"+inum+".png' alt='' />");
    }
    //3 폭죽 D
    for ( i=0; i <20; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section3 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_D/Type_D_000"+inum+".png' alt='' />");
    }
    //3 폭죽 C
    for ( i=0; i <14; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section3 .ftype3").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_C/Type_C_000"+inum+".png' alt='' />");
    }
    
     //4 폭죽 F
    for ( i=0; i <24; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section4 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_F/Type_F_000"+inum+".png' alt='' />");
    }
    //4 폭죽 D
    for ( i=0; i <20; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section4 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_D/Type_D_000"+inum+".png' alt='' />");
    }
    //4 폭죽 C
    for ( i=0; i <14; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section4 .ftype3").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_C/Type_C_000"+inum+".png' alt='' />");
    }
    
    //5 폭죽 F
    for ( i=0; i <24; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section5 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_F/Type_F_000"+inum+".png' alt='' />");
    }
    //5 폭죽 D
    for ( i=0; i <20; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section5 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_D/Type_D_000"+inum+".png' alt='' />");
    }
    //5 폭죽 C
    for ( i=0; i <14; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section5 .ftype3").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/Type_C/Type_C_000"+inum+".png' alt='' />");
    }
    
    
    //6 폭죽 F
    for ( i=0; i <25; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section6 .ftype1").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/smallType/type_A/OutPut_A_Small_000"+inum+".png' alt='' />");
    }
    //5 폭죽 D
    for ( i=0; i <28; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section6 .ftype2").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/smallType/type_B/OutPut_B_Small_000"+inum+".png' alt='' />");
    }
    //5 폭죽 E
    for ( i=0; i <16; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section6 .ftype3").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/fire_seq/smallType/type_C/OutPut_C_Small_000"+inum+".png' alt='' />");
    }
}

function linesetting(num){
    //1 폭죽 A
    for ( i=5; i <66; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section"+(num+1)+" .linedown").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/LineMotion/S0"+num+"/Line_Motion_S0"+num+"_OUTPUT_000"+inum+".png' alt='' />");
    }
    
    for ( i=5; i <66; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section"+(num+1)+" .lineup").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/LineMotion/S0"+num+"/reverse/Line_Motion_S0"+num+"_OUTPUT_Reverse_000"+inum+".png' alt='' />");
    }
    for ( i=0; i <35; i++ ) {
        if(i<10){
            inum = "0"+i;
        }else{
            inum = i;
        }
        $(".section6 .linedown").append("<img src='http://cdn.hanwhafireworks.com/web/images/main/LineMotion/S05/Line_Motion_BT_OUTPUT_000"+inum+".png' alt='' />");
    }
    
    
}