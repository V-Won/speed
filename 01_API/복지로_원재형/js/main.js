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
		$("div.notice").spTab();

		// rolling
		$("div.visual_area").spRolling1();
		$("div.notify").spRolling2();

		// 공감복지만화 pagging
		$("ul.cartoon_list").spPagging();
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

	// simple rolling1 -> spRolling1
	$.fn["spRolling1"] = function () {		
		var spRolling = $(this),
			linkArr = spRolling.children("div").children("a"),
			imgArr = spRolling.children("ul").children("li"),
			linkArrImg = linkArr.children("img"),
			len = linkArr.length - 2,
			view = 0,
			fadeTime = 200,
			onImg = linkArrImg.eq(0).attr("src"),
			offImg = linkArrImg.eq(1).attr("src"),
			to = null,
			toTime = 5000,
			flag = true;
		
		linkArr.click(click);		
		
		function click(num) {
			if (typeof num != "number") num = $(this).index(); 
			
			if (num == len) {
				run();
			} else if (num == len + 1) {
				flag = false;
				clearInterval(to);
			} else if (view != num) {
				imgArr.eq(view).fadeToggle(fadeTime);
				linkArrImg.eq(view).attr("src", offImg);
				
				imgArr.eq(num).delay(fadeTime).fadeToggle(fadeTime);
				linkArrImg.eq(num).attr("src", onImg);
				
				view = num;

				if (flag) run();
			}

			return false;
		}

		function play() {
			var num = view + 1;

			if (num >= len) num = 0;

			click(num);

			run();
		}

		function run() {
			clearInterval(to);
			to = setTimeout(play, toTime);	
		}

		run();
	};

	// simple rolling2 -> spRolling2
	$.fn["spRolling2"] = function () {		
		var spRolling = $(this),
			linkArr = spRolling.children("ul").children("li").children("a"),
			imgArr = spRolling.children("ul").children("li").children("div"),
			linkArrImg = linkArr.children("img"),
			len = linkArr.length,
			view = 0,
			fadeTime = 200,
			onImg = linkArrImg.eq(0).attr("src"),
			offImg = linkArrImg.eq(1).attr("src"),
			to = null,
			toTime = 5000,
			flag = true
			playBtn = spRolling.children(".play").children("a"),
			stopBtn = spRolling.children(".stop").children("a");
		
		linkArr.click(click);		  

		function click(num) {
			if (typeof num != "number") num = linkArr.index(this);  

			if (view != num) {
				imgArr.eq(view).fadeToggle(fadeTime);
				linkArrImg.eq(view).attr("src", offImg);
				
				imgArr.eq(num).delay(fadeTime).fadeToggle(fadeTime);
				linkArrImg.eq(num).attr("src", onImg);
				
				view = num;

				if (!flag) clearInterval(to);
			}

			return false;
		}

		playBtn.click(function () {
			run();
			return false;
		});

		stopBtn.click(function () {
			flag = false;
			clearInterval(to);
			return false;
		});

		function play() {
			var num = view + 1;

			if (num >= len) num = 0;

			click(num);

			run();
		}

		function run() {
			clearInterval(to);
			to = setTimeout(play, toTime);	
		}

		run();
	};

	// simple pagging -> spPagging
	$.fn["spPagging"] = function () {
		var spPagging = $(this),
			next = spPagging.children("li.next"),
			prev = spPagging.children("li.prev"),
			thumb = spPagging.children("li").not("li.next, li.prev, li.more"),
			view = 0,
			turn = 3,
			len = thumb.length;

		prev.click(function () {
			if(view - turn >= 0) {
				view = view - turn;
				thumb.filter(":visible").hide();

				for (var i = view; i < view + 3; i++) {
					thumb.eq(i).show();
				}
			}

			return false;
		});

		next.click(function () {
			if(view + turn < len) {
				view = view + turn;
				thumb.filter(":visible").hide();

				for (var i = view; i < view + 3; i++) {
					thumb.eq(i).show();
				}
			}		

			return false;
		});
	};
}) (jQuery);  