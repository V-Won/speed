//select
$(document).ready(function(){
	var isios=(/(ipod|iphone|ipad)/i).test(navigator.userAgent);//ios
	var isipad=(/(ipad)/i).test(navigator.userAgent);//ipad
	var isandroid=(/android/i).test(navigator.userAgent);//android
	if(!isios && !isipad && !isandroid){
		// designed combobox
		 if ( $(".select").length) {
			$(".select").fe_select();
		}
	}
});

//gnb
$(function(){
	var body = $('html, body'),
		win = $(window),
		winH = win.height(),
		gnb = $('#gnb'),
		gnbMenu = gnb.find('.menu'),
		gnbH1 = gnb.find('.top-area > h1'),
		gnbChildren = $('#gnb .link, #gnb .gnb-menu, #gnb .gnb-menu > li > a, #gnb .top-area > ul'),
		gnbLi = gnb.find('.gnb-menu > li'),
		gnbBg = gnb.find('.gnb-bg'),
		gnbSpd = 350,
		easingMotion = 'easeOutCirc',
		state = false,
		gnbIdx;


	gnbChildren.css({'opacity':0});
	$(window).on('resize', function(){

		winH = win.height();
		gnbBg.css('height', 0);

		if(state){
			gnbLi.eq(gnbIdx).trigger('mouseenter');
		}

	});

	//gnb
	var gnbMotion = {

		hover : function(){

			state = true;

			gnb.stop().animate({
				width: 300
			},{
				duration:gnbSpd, easing: easingMotion
			});
			gnbH1.stop().animate({
				paddingTop: 27
			},{
				duration:gnbSpd, easing: easingMotion
			});

			gnbChildren.stop().css('display','block').animate({
				opacity: 1
			},{
				duration:gnbSpd, easing: easingMotion
			});
			gnbMenu.stop().animate({
				left : -20,
				opacity : 0
			},{
				duration:gnbSpd, easing: easingMotion
			});
			
		},

		leave : function(){
			state = false;

			gnb.stop().animate({
				width: 70
			},{
				duration:gnbSpd, easing: easingMotion
			});

			gnbH1.stop().animate({
				paddingTop: 37
			},{
				duration:gnbSpd, easing: easingMotion
			});

			gnbChildren.stop().animate({
				opacity: 0
			},{
				duration:gnbSpd, easing: easingMotion, complete : function(){
					gnbChildren.hide();
				}
			});
			gnbMenu.stop().animate({
				left : 25,
				opacity : 1
			},{
				duration:gnbSpd, easing: easingMotion
			});
			gnbLi.find('>ul').hide();
		},

		gnbMenuHover : function(e){
			e.find('ul').stop().fadeIn();
			gnbBg.stop().css('display','block').animate({
				opacity : 1,
				height : winH - e.position().top
			},{
				duration:gnbSpd, easing: easingMotion
			});
		},
		gnbMenuLeave : function(e){
			e.find('ul').stop().fadeOut();
			gnbBg.stop().animate({
				opacity : 0
			},{
				duration:gnbSpd, easing: easingMotion, complete : function(){
					gnbBg.hide();
				}
			});
		}

	};

	gnb.on('mouseenter', function(){
		if(!state){
			gnbMotion.hover();
		}
	});
	gnb.on('mouseleave', function(){
		if(state){
			gnbMotion.leave();
		}
	});

	gnbLi.on('mouseenter focusin', function(){
		var $this = $(this);

		gnbIdx = gnbLi.index($this);
		gnbMotion.gnbMenuHover($this);
	});
	gnbLi.on('mouseleave focusout', function(){
		var $this = $(this);

		gnbIdx = gnbLi.index($this);
		gnbMotion.gnbMenuLeave($this);
	});

	gnbH1.on('focusin', function(){
		gnb.trigger('mouseenter');
	});
	gnb.siblings().find('a').on('focusin', function(){
		gnb.trigger('mouseleave');
	});


});

//subMenu
$(function(){
	var win = $(window),
		top = $('#dHead'),
		topLogo = top.find('.logo'),
		topLoca = top.find('.top-location'),
		topUtill = top.find('.top-utill'),
		topH2 = top.find('h2 a'),
		topSubBtn = $('#dHead h2 a, #dBody > h3'),
		topSub = top.find('.sub-menu'),
		topSubA = topSub.find('a'),
		caseBox = $('.case-box > div'),
		dBodyH3 = $('#dBody > h3'),
		subSpd = 350,
		easingMotion = 'easeOutCirc',
		topState = false;


	topSubBtn.on('mouseenter', function(){
		topSub.stop().css('display','block').animate({
			opacity: 1
		},{
			duration:subSpd, easing: easingMotion
		});
		topSubA.stop().animate({
			opacity: 1
		},{
			duration:subSpd, easing: easingMotion
		});
	});
	topSub.on('mouseleave', function(){
		topSub.stop().animate({
			opacity: 0
		},{
			duration:subSpd, easing: easingMotion, complete : function(){
				topSub.hide();
			}
		});
		topSubA.stop().animate({
			opacity: 0
		},{
			duration:subSpd, easing: easingMotion
		});
	});

	topH2.on('focusin', function(){
		topSubBtn.trigger('mouseenter');
	});

	win.on('scroll', function(){
		var winTop = $(window).scrollTop();

		if(winTop>0){
			topState = true;
		}else {
			topState = false;
		}
		topFixed();
	});

	function topFixed(){
		if (topState) {
			top.stop().animate({
				top: -64
			},{
				duration:subSpd, easing: easingMotion
			});
			topLogo.stop().animate({
				marginTop: -64,
				paddingBottom : 64
			},{
				duration:subSpd, easing: easingMotion
			});

			// ie7
			var browNum;
			( navigator.userAgent.indexOf( 'MSIE 7' ) !== -1 ) ? browNum = 91 : browNum = 155 ;
				
			topLoca.stop().animate({
				top : browNum+1
			},{
				duration:subSpd, easing: easingMotion
			});
			topUtill.stop().animate({
				top : browNum
			},{
				duration:subSpd, easing: easingMotion
			});
			
			caseBox.stop().animate({
				top : 192
			},{
				duration:subSpd, easing: easingMotion
			});
		}else {
			top.stop().animate({
				top: 0
			},{
				duration:subSpd, easing: easingMotion
			});
			topLogo.stop().animate({
				marginTop: 0,
				paddingBottom : 0
			},{
				duration:subSpd, easing: easingMotion
			});
			topLoca.stop().animate({
				top : 56
			},{
				duration:subSpd, easing: easingMotion
			});
			topUtill.stop().animate({
				top : 55
			},{
				duration:subSpd, easing: easingMotion
			});
			caseBox.stop().animate({
				top : 128
			},{
				duration:subSpd, easing: easingMotion
			});
		}
	}

});

// layer-agree
$(function(){
	var footBtn = $('#dFoot .copy-address > a').eq(0),
		layerBg = $('.layer-bg'),
		layerWrap = $('#layerWrap'),
		layerTab = layerWrap.find('.tab a'),
		layerAgree = layerWrap.find('.layer-agree > div'),
		layerClose = layerWrap.find('.layer-close');


	footBtn.on('click', function(){
		layerBg.show();
		layerWrap.show();
		layerTab.eq(0).trigger('click');

		return false;
	});
	layerClose.on('click', function(){
		layerBg.hide();
		layerWrap.hide();

		return false;
	});

	layerTab.on('click', function(){
		var $this = $(this),
			idx = layerTab.index($this);

		layerTab.removeClass('on');
		$this.addClass('on');
		layerAgree.hide();
		layerAgree.eq(idx).show();

		return false;

	});

});