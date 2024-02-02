// quick
$(function(){
	var quick = $('.main-quick a'),
		easi = 'easeInOutExpo',
		speed = 700;

	quick.on('click', function(){
		var $this = $(this),
			href = $this.attr('href'),
			body = $('html, body'),
			scrollPosition = $(href).position().top;

		if(href == null){return false;}

		body.stop().animate({
			scrollTop : scrollPosition
		}, {
			duration:speed, easing: easi
		});

		return false;
	});

	function quickMenu(cur){
		quick.removeClass('on');
		quick.eq(cur).addClass('on');
	}

	$(window).on('scroll', function(){

		var $winTop = $(window).scrollTop(),
			$winH = $(window).height(),
			$menu01 = $('#mainSection01').position().top,
			$menu02 = $('#mainSection02').position().top,
			$menu03 = $('#mainSection03').position().top,
			$menu04 = $('#mainSection04').position().top,
			$menu05 = $('#mainSection05').position().top,
			bg01 =  $('#mainSection02'),
			bg02 =  $('#mainSection03'),
			bg03 =  $('#mainSection04'),
			img01 =  $('.paral01-img01'),
			img02 =  $('.paral01-img02'),
			img03 =  $('.paral01-img03'),
			img04 =  $('.paral02-img01'),
			img05 =  $('.paral02-img02'),
			img06 =  $('.paral02-img03'),
			visualImg =  $('#mainSection01 .image img'),
			ring =  $('#mainSection01 .ring');

		// quick menu on/off
		if ($menu01 <= $winTop  && $winTop < $menu02){
			quickMenu(0);
			visualImg.css('top',$winTop * 0.8);
			ring.css('top',$winTop * -0.2 + 680);
		}else if ($menu02 <= $winTop && $winTop < $menu03){
			quickMenu(1);
		}else if ($menu03 <= $winTop && $winTop < $menu04){
			quickMenu(2);
		}else if ($menu04 <= $winTop && $winTop < $menu05){
			quickMenu(3);
		}else if ($menu05 <= $winTop){
			quickMenu(4);
		}

		// bg
		if ($menu02 <= $winTop+$winH  && $winTop < $menu02+bg01.height()){
			bg01.css('background-position','center '+(($winTop-$menu02 - bg01.height()+800) * 0.7 )+'px');
		}
		if ($menu03 <= $winTop+$winH  && $winTop < $menu03+bg02.height()){
			bg02.css('background-position','center '+(($winTop-$menu03 - bg02.height()+1200) * 1.1 )+'px');
		}
		if ($menu04 <= $winTop+$winH  && $winTop < $menu05+bg03.height()){
			bg03.css('background-position','center '+(($winTop-$menu05 - bg03.height()+2100) * 1.1 )+'px');
		}


		// object
		img01.css('top',$winTop * 0.8 - 440);
		img02.css('top',$winTop * -0.7 + 1280);
		img04.css('top',$winTop * 0.3 - 1750);
		// img05.css('top',$winTop * 0.5 - 1050);
		img06.css('top',$winTop * -0.8 + 3200);

	});

	//IE, Opera, Safari
	$(window).on('mousewheel', function(e){

		if(e.originalEvent.wheelDelta < 0) {
			//scroll down
			$('html, body').stop().animate({
				scrollTop : '+=200px'
			},350);
		}else {
			//scroll up
			$('html, body').stop().animate({
				scrollTop : '-=200px'
			},350);
		}

		//prevent page fom scrolling
		return false;
	});

});


// visual
$(function(){

	var visual = $('.main-visual'),
		visualUl = visual.children('ul'),
		easi = 'easeInOutExpo',
		speed = 500;

	visualUl.find('.text').css('opacity',0);
	visualUl.find('.ring').css('opacity',0);

		var numLef,
			txtLef = 812,
			ringTop = 683;

		$('.main-visual ul .text, .main-visual ul .ring').stop().animate({
			opacity : 0
		}, {
			duration:speed, easing: easi, complete : function(){
				visualUl.find('.text').css('left',400);
			}
		});
		
		visualUl.children('li').find('.text').animate({
			opacity : 1,
			left : txtLef
		}, {
			duration:speed+200, easing: 'easeOutExpo'
		});
		visualUl.children('li').find('.ring').delay(200).animate({
			opacity : 1
		}, {
			duration:speed+300, easing: 'easeOutExpo'
		});


});

// mainSection05
$(function(){
	var mainSection05 = $('#mainSection05'),
		tab = mainSection05.children('a'),
		box = mainSection05.children('div'),
		jewelryList = mainSection05.find('.jewelry-box'),		
		btn = mainSection05.find('>div>a'),
		speed = 500,
		easi = 'easeInOutExpo';

	tab.on('click', function(){
		var $this = $(this),
			$next = $this.next();

		jewelryList.css('margin-left',0);

		tab.removeClass('on');
		$this.addClass('on');

		box.hide();
		$next.fadeIn();

		return false;
	});

	btn.on('click', function(){
		var $this = $(this),
			lef;

		($this.hasClass('btn-next')) ? lef = -705 : lef = 0;

		jewelryList.stop().animate({
			marginLeft : lef
		}, {
			duration:speed, easing: easi
		});

		return false;
	});
});

// spon
$(function(){
	var spon = $('.spon-box'),
		sponList = spon.find('.spon-list > div'),
		play = spon.find('.play'),
		pause = spon.find('.pause'),
		lef = 0;

	var timer = setInterval(sponRoll, 30);

	function sponRoll(){

		(lef == -1267) ? lef = 0 : lef-- ;

		sponList.css('margin-left',lef);
	}

	pause.on('click', function(){
		clearInterval(timer);

		return false;
	});

	play.on('click', function(){
		clearInterval(timer);
		timer = setInterval(sponRoll, 30);

		return false;
	});

	// sponList.on('mouseenter', function(){ pause.trigger('click') });
	// sponList.on('mouseleave', function(){ play.trigger('click') });

});