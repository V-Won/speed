$(document).ready(function() {	$(window).scroll(function(){		var top = $(window).scrollTop();		$("#test span").text(top);		scrollEvent()	});	$(window).resize(function(){		scrollEvent()	});	/* Home */	$("h1").click(function(){		$("html, body").animate({scrollTop: $("#layout_Home").offset().top}, 500, "easeInOutCubic");		return false;	});	/* Gnb Link Min */	$(".gnb > li > a").click(function(){		var num = $(this).parent().index();		var move_layout = $("#contentWrap > div");		$("html, body").animate({scrollTop: $(move_layout).eq(num+1).offset().top}, 500, "easeInOutCubic");		return false;	});		/* Gnb Link 	$(".gnb > li:eq(0) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_About").offset().top}, 500, "easeInOutCubic");		return false;	});	$(".gnb > li:eq(1) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_Portfolio").offset().top}, 500, "easeInOutCubic");		return false;	});	$(".gnb > li:eq(2) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_Skills").offset().top}, 500, "easeInOutCubic");		return false;	});	$(".gnb > li:eq(3) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_Study").offset().top}, 500, "easeInOutCubic");		return false;	});	$(".gnb > li:eq(4) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_Contact").offset().top}, 500, "easeInOutCubic");		return false;	});	$(".gnb > li:eq(5) > a").click(function(){		$("html, body").animate({scrollTop: $("#layout_Test").offset().top}, 500, "easeInOutCubic");		return false;	});			*/	function scrollEvent(){		locate = $(window).scrollTop();		if (locate < 990){			home_on(0);		} else if (locate >= 990 && locate < 1980){			gnb_on(0);		} else if (locate >= 1980 && locate < 2970){			gnb_on(1);		} else if (locate >= 2970 && locate < 3960){			gnb_on(2);		} else if (locate >= 3960 && locate < 4950){			gnb_on(3);		} else if (locate >= 4950 && locate < 5940){			gnb_on(4);		} else if (locate >= 5940){			gnb_on(5);		}	}	function gnb_on(num) {		var gnb_on = $(".gnb > li").eq(num).children("a").children("img").attr("src");		var home_off = $("h1 > a > img").attr("src");		$("h1 > a > img").attr("src",home_off.replace("_on","_off"));		$(".gnb > li").siblings().each(function() {			var gnb_off = $(this).children("a").children("img").attr("src");			$(this).children("a").children("img").attr("src",gnb_off.replace("_on","_off"));			$(this).children("a").children(".txt_menu").css("opacity","0.2");		});		$(".gnb > li").eq(num).children("a").children("img").attr("src",gnb_on.replace("_off","_on"));		$(".gnb > li").eq(num).children("a").children(".txt_menu").css("opacity","1");	}	function home_on(num) {		var home_on = $("h1 > a > img").attr("src");		$(".gnb > li").siblings().each(function() {			var gnb_off = $(this).children("a").children("img").attr("src");			$(this).children("a").children("img").attr("src",gnb_off.replace("_on","_off"));			$(this).children("a").children(".txt_menu").css("opacity","0.2");		});		$("h1 > a > img").attr("src",home_on.replace("_off","_on"));	}	});