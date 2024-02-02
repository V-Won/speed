
$(document).ready(function() {

	$(function () {
		// 전체 메뉴 버튼
		$("p.whole_menu > a").click(function () {
			$("div.whole_menu_view").removeClass("hidden");
			return false;
		});
		
		// 전체메뉴 닫기 버튼
		$("p.close > a").click(function () {
			$("div.whole_menu_view").addClass("hidden");
			return false;
		});
	});

	$(".ctab h5 a").click(function() {
		$(".tabSc").css("display", "none");
		$(".guidetab").css("display", "none");
		$(this).parent().next().css("display", "block");
		$(".ctab h5").removeClass("current");
		$(this).parent().addClass("current");
		return false;
	});

	$(".atag01").toggle(function() {
			$(".press_drop01").css("display", "block");
			$(".serviceBox01").addClass("serviceImg01");
			}, function() {
			$(".press_drop01").css("display","none");	
			$(".serviceBox01").removeClass("serviceImg01")
		});
		$(".press_drop01 li a").click(function() {
			$(".press_drop01").css("display", "none");
			$(".atag01").text($(this).text());
			$(".serviceBox01").removeClass("serviceImg01");
			return false;
		});

		$(".comment").click(function() {
			$(".comment").css("background-image", "none");
		});

});
