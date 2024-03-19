
//load
// $('#g_top').after('<div id="load_g_top"></div>');
// $('#g_top').remove();
// $('#g_header .g_wrap').after('<div id="load_g_wrap"></div>');
// $('#g_header .g_wrap').remove();
// $('#g_footer').after('<div id="load_g_footer"></div>');
// $('#g_footer').remove();

// $('body').append('<div id="vertualLoad" class="hidden"></div>');

// $('#vertualLoad').load('../00_filelist/static/inc/common.html',function(){
// 	//header
// 	var htmlHeader = $('#vertualLoad').find('#g_top').clone(true);
// 	$('#load_g_top').html(htmlHeader);
// 	//tab
// 	var htmlTab = $('#vertualLoad').find('#g_header .g_wrap').clone(true);
// 	$('#load_g_wrap').html(htmlTab);
// 	//해당파일명일시 탭 활성화
// 	var urlText = location.href;
// 	if (urlText.indexOf('filelist.html') != -1) {
// 		$('.g_gnb > li').eq(0).addClass('g_on');
// 	}else if (urlText.indexOf('guide_info.html') != -1) {
// 		$('.g_gnb > li').eq(1).addClass('g_on');
// 	}else if (urlText.indexOf('guide_code.html') != -1) {
// 		$('.g_gnb > li').eq(2).addClass('g_on');
// 	}
// 	//footer
// 	var htmlFooter = $('#vertualLoad').find('#g_footer').clone(true);
// 	$('#load_g_footer').html(htmlFooter);
// 	//remove
// 	$('#vertualLoad').remove();
// });

//페이지 상단 navi 부분 (top + info btn)
$(".g_main_description").show();
$(".g_main_description_btn").addClass('on');
var scrollCheck = 0;
$(window).on('scroll', function () {
	if (scrollCheck == 0) {
		$(".g_main_description").hide();
		$(".g_main_description_btn").removeClass('on');
		scrollCheck = 1;
	};
});
$(".g_main_description_btn").hover(function () {
	if ($(".g_main_description").css('display') != 'none') {
		$(".g_main_description").show();
	} else {
		$(".g_main_description").hide();
	};
});
$(".g_main_description_btn").on('mouseenter focusin', function () {
	$(".g_main_description").show();
	$(".g_main_description_btn").addClass('on');
});
$(".g_main_description_btn").on('mouseleave focusout', function () {
	$(".g_main_description").hide();
	$(".g_main_description_btn").removeClass('on');
});

//ag-filelist.html에서 td class="g_status"에 상태 입력시 색상 변경
$(".g_status_board").each(function () {
	$('td.g_status').each(function () {
		var vars = $(this).text();
		var txt01 = "수정";
		var txt02 = "완료";
		if (vars == txt01) {
			$(this).parent('tr').addClass('g_ing');
		} else if (vars == txt02) {
			$(this).parent('tr').addClass('g_fin2');
		}
	});
});

/*ie7*/
$(".g_tab li:first").addClass("g_first");

// top 버튼
$('#btnTop').on('click', function (e) {
	e.preventDefault();
	$('html, body').stop().animate({ scrollTop: 0 });
});

// header 고정
let itemTop = $('.g_container').offset().top;

$(window).on(' scroll', function () {
	let wTop = $(this).scrollTop();

	if (wTop >= itemTop) {
		$('#g_header').addClass('fx');
		$('#g_content').css('margin-top', $('#g_header').outerHeight(true) + 'px');
	} else {
		$('#g_header').removeClass('fx');
		$('#g_content').css('margin-top', '0px');
	};
});

$('.g_gnb li a').click(function () {
	$('.g_gnb li').removeClass('g_on');
	$(this).parents('li').addClass('g_on');
});
