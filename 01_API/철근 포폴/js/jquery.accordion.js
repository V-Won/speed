$(document).ready(function() {
	$(".accordion > li").mouseover(function() {
		$(".accordion > li").removeClass("on");
		$(".accordion > li").siblings().each(function() {
			var off = $(this).children("p").children("img").attr("src");
			$(this).children("p").children("img").attr("src",off.replace("_on","_off"));
			$(this).children(".about_detail").children().children("em").css("display","none");
		});		
		$(".accordion > li").stop().animate({width:"128px"},200);

		$(this).addClass("on");
		var on = $(this).children("p").children("img").attr("src");
		$(this).children("p").children("img").attr("src",on.replace("_off","_on"));
		$(this).children(".about_detail").children().children("em").css("display","block");
		$(this).stop().animate({width:"292px"},200);
	});
});