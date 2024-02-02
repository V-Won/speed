$(document).ready(function() {
	$(".mid_slide").mouseover(function() {
		var top = $(this).children(".top").children("img").attr("src");
		$(this).children(".top").children("img").attr("src",top.replace("_off","_on"));
		var bottom = $(this).children(".bottom").children("img").attr("src");
		$(this).children(".bottom").children("img").attr("src",bottom.replace("_off","_on"));	
		$(this).children(".mid").css("border-top","1px solid #999999");
		$(this).children(".mid").css("border-bottom","1px solid #999999");
		$(this).children(".mid").stop().animate({height:"45px"},300);
	});
	$(".mid_slide").mouseout(function() {
		var top = $(this).children(".top").children("img").attr("src");
		$(this).children(".top").children("img").attr("src",top.replace("_on","_off"));
		var bottom = $(this).children(".bottom").children("img").attr("src");	
		$(this).children(".bottom").children("img").attr("src",bottom.replace("_on","_off"));
		$(this).children(".mid").stop().animate({height:"0px"},300);	
		$(this).children(".mid").css("border-top","none");
		$(this).children(".mid").css("border-bottom","none");		
	});
});