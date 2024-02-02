(function ($) {
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

		// tab
		$("div.welfair_system").spTab();

		// pagging
		$("div.cartoon_list > ul").spPagging();
	});
	
	// simple tab -> spTab
	$.fn["spTab"] = function () {
		var spTab = $(this), // tab을 감싸고 있는 wrap
			linkArray = spTab.find("h4 > a"); // 탭 제목들

		linkArray.click(function () { // 탭 제목을 클릭했을 
			var link = $(this);	// 클릭된 탭 제목

			if (!link.hasClass("on")) { // on인 탭이 아닐때 동작함
				spTab.children("ul").addClass("hidden"); // 보여주고 있는 탭 내용을 숨김
				linkArray.removeClass("on"); // on 상태의 탭을 없앰

				link.parent().next().removeClass("hidden"); // 선택된 탭의 내용을 보여줌
				link.addClass("on"); // 선택된 탭 제목을 on상태로 변경
			}

			return false;
		});
	};

	// simple pagging -> spPagging
	$.fn["spPagging"] = function () {
		var spPagging = $(this),
			next = spPagging.children("li.next"),
			prev = spPagging.children("li.prev"),
			thumb = spPagging.children("li").not("li.next, li.prev, li.more"),
			view = 0,
			turn = 5,
			len = thumb.length;

		prev.click(function () {
			if(view - turn >= 0) {
				view = view - turn;
				thumb.filter(":visible").hide();

				for (var i = view; i < view + turn; i++) {
					thumb.eq(i).show();
				}
			}

			return false;
		});

		next.click(function () {
			if(view + turn < len) {
				view = view + turn;
				thumb.filter(":visible").hide();

				for (var i = view; i < view + turn; i++) {
					thumb.eq(i).show();
				}
			}		

			return false;
		});
	};
}) (jQuery);  