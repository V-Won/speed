if (window.console == undefined) { console = { log: () => {} } }; 

/* tabScrollClick */
(function (window, undefined) {
	"use strict";
	/**
	 * @description tab 스크롤 및 클릭
	 * @modify
			@20230000 추가
	*/
	var tabScrollClick = {
		/** 플러그인명 */
		bind: tabScrollClick,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: document.querySelector('[data-event="tab"]')
		},
		initialize: function() {
			const me = this;

			me._scroll();
			me._click();
		},
		_scroll: function(){
			const me = this,
						tg = me.selectors.tg;

			window.onscroll = (e) => {
				let windowTop = window.scrollY;

				console.log(e);

				document.querySelectorAll('[data-event=tab-section] .item').forEach((e) => {
					let sectionTop = e.offsetTop - 50,
							itemHeight = e.clientHeight;

					if( windowTop >= sectionTop && windowTop <= sectionTop + itemHeight ){
						let cnt = e.getAttribute('data-section') - 1;

						tg.querySelectorAll('li').forEach(e => {
							e.classList.remove('sel');
						});
						
						tg.querySelectorAll('li')[cnt].classList.add('sel');
					}
				});
			}
		},
		_click: function(){
			const me = this,
						tg = me.selectors.tg;

			const clickItems = tg.querySelectorAll('li button');

			for( const clickItem of clickItems ){
				clickItem.onclick = (e) => {
					let cnt = e.target.parentElement.getAttribute('data-tab');

					let top = document.querySelector('[data-section="' + cnt + '"]').offsetTop;

					window.scrollTo({ top: top, behavior: "smooth" });
				}
			}
		}
	};

	window.tabScrollClick = tabScrollClick;
}(window));

/* selectBox */
(function (window, undefined) {
	"use strict";
	/**
	 * @description selectBox
	 * @modify
			@20230000 추가
	*/
	var selectBox = {
		/** 플러그인명 */
		bind: selectBox,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="selectBox"]'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						tg = me.selectors.tg;

			const selectBoxs = document.querySelectorAll(tg);

			for( const selectBox of selectBoxs ){
				selectBox.querySelector('.selectBox > button').onclick = e => {
					let parent = e.target.parentElement;
					
					if( !parent.classList.contains('is-active') ){
						selectBoxs.forEach(e => {
							if( e.classList.contains('is-active') ){
								e.classList.remove('is-active');
							}
						});
						if( !parent.classList.contains('disabled') ){
							parent.classList.add('is-active');
						}
					}else{
						parent.classList.remove('is-active');
					}
				}
			}

			document.querySelectorAll('.selectBox li button').forEach(e => {
				e.onclick = () => {
					e.parentNode.parentNode.parentNode.querySelector('.selectBox > button').innerText = e.innerText;
				}
			});

			window.addEventListener('click', (e) => {
				if( !e.target.classList.contains('button') ){
					selectBoxs.forEach(e => {
						e.classList.remove('is-active');
					});
				}
			})
		}
	};

	window.selectBox = selectBox;
}(window));

/* checkboxAll */
(function (window, undefined) {
	"use strict";
	/**
	 * @description checkboxAll
	 * @modify
			@20230000 추가
	*/
	var checkboxAll = {
		/** 플러그인명 */
		bind: checkboxAll,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="checkboxAll"]',
			tg2: '[data-event="checkbox"]'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						tg = me.selectors.tg,
						tg2 = me.selectors.tg2;

			let ck = (st, item) => {
				st == "on" ? item.checked = true : item.checked = false;
			}

			document.querySelectorAll(tg + ' input').forEach( e => {
				e.onclick = (e) => {
					document.querySelectorAll('input[name="' + e.target.name + '"]').forEach( item => {
						e.target.checked ? ck('on', item) : ck('off', item);
					});
				}
			});

			document.querySelectorAll(tg2 + ' input').forEach( e => {
				e.onclick = (e) => {
					if( document.querySelectorAll('[data-event="checkbox"] input[name="' + e.target.name + '"]').length == document.querySelectorAll('[data-event="checkbox"] input[name="' + e.target.name + '"]:checked').length ){
						ck('on', document.querySelector('[data-event="checkboxAll"] input[name="' + e.target.name + '"]'));
					}else{
						ck('off', document.querySelector('[data-event="checkboxAll"] input[name="' + e.target.name + '"]'));
					}
				}
			});
		}
	};

	window.checkboxAll = checkboxAll;
}(window));

/* tab menu */
(function (window, undefined) {
	"use strict";
	/**
	 * @description tab 메뉴 클릭
	 * @modify
			@20230000 추가
	*/
	var tabMenu = {
		/** 플러그인명 */
		bind: tabMenu,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="tabMenu"]',
			tg2: '[data-event="tabMenu-section"]'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						tg = me.selectors.tg,
						tg2 = me.selectors.tg2;

			const tgs = document.querySelectorAll(tg + ' li button');

			document.querySelectorAll(tg + ' li').forEach(e => {
				let item = e.classList.contains('is-active');

				if( item ){
					const current = e.getAttribute('data-tab');
					document.querySelector('[data-section="' + current + '"]').classList.add('is-active');
				}
			});

			for( const tg of tgs ){
				tg.onclick = e => {
					// tab button
					document.querySelectorAll('[data-event="tabMenu"] li').forEach(item => {
						item.classList.remove('is-active');
					});
					e.target.parentNode.classList.add('is-active');

					// tab 내용
					const idx = e.target.parentNode.getAttribute('data-tab');
					
					document.querySelectorAll(tg2 + ' [data-section]').forEach(e => {
						e.classList.remove('is-active');
					});

					document.querySelector(tg2 + ' [data-section="' + idx + '"]').classList.add('is-active');
				}
			}
		}
	};

	window.tabMenu = tabMenu;
}(window));

/* progress bar */
(function (window, undefined) {
	"use strict";
	/**
	 * @description scroll 진행 bar
	 * @modify
			@20230000 추가
	*/
	var progressBar = {
		/** 플러그인명 */
		bind: progressBar,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="progressBar"]'
		},
		initialize: function() {
			const me = this;

			me._scroll();
		},
		_scroll: function(){
			const me = this,
						tg = me.selectors.tg;

			window.onscroll = (e) => {
				let windowTop = window.scrollY,
						bodyHg = document.body.scrollHeight,
						wdHg = window.innerHeight,
						wd = (windowTop / (bodyHg - wdHg)) * 100;

				document.querySelector('[data-event="progressBar"]').style.width = wd + "%";
			}
		}
	};

	window.progressBar = progressBar;
}(window));

/* Hamburger Icon */
(function (window, undefined) {
	"use strict";
	/**
	 * @description Hamburger Icon Animations
	 * @modify
			@20230000 추가
	*/
	var hamburgerIcon = {
		/** 플러그인명 */
		bind: hamburgerIcon,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '.hamburger'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						tg = me.selectors.tg;

			const tgs = document.querySelectorAll(tg);

			for( const tg of tgs ){
				tg.classList.add('is-active');
				tg.onclick = e => {
					e.currentTarget.classList.toggle('is-active');
				}
			}
		}
	};

	window.hamburgerIcon = hamburgerIcon;
}(window));

/* Layer popup */
(function (window, undefined) {
	"use strict";
	/**
	 * @description Layer popup
	 * @modify
			@20230000 추가
	*/
	var layerPopup = {
		/** 플러그인명 */
		bind: layerPopup,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			openBtn: '[data-event="layerOpen"]',
			closeBtn : '[data-event="layerClose"]'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						openBtn = me.selectors.openBtn,
						closeBtn = me.selectors.closeBtn;

			const openBtns = document.querySelectorAll(openBtn),
						closeBtns = document.querySelectorAll(closeBtn);

			for( const tg of openBtns ){
				tg.onclick = e => {
					let target = e.target.getAttribute('data-layerId');

					document.querySelector('#' + target).style.display = 'block';
					document.querySelector('#' + target).scrollTo(0, 0);
					document.querySelector('#' + target + ' .inner-layer').focus();
					document.body.classList.add('oh');
				}
			};

			for( const tg of closeBtns ){
				tg.onclick = e => {
					layerClose();
				}
			};

			document.querySelectorAll('.box-layer').forEach(e => {
				e.onclick = e => {
					if( e.target.classList.contains('box-layer') ){
						layerClose();
					}
				}
			});

			const layerClose = function(){
				document.querySelectorAll('.box-layer').forEach(e => {
					e.style.display = 'none';
				});

				document.body.classList.remove('oh');
			}
		}
	};

	window.layerPopup = layerPopup;
}(window));

/* randomInnerHtml */
(function (window, undefined) {
	"use strict";
	/**
	 * @description random innerHtml
	 * @modify
			@20230000 추가
	*/
	var randomInsert = {
		/** 플러그인명 */
		bind: randomInsert,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			random1: '[data-event="randomInsert"]',
			random2 : '[data-event="randomInsert2"]'
		},
		initialize: function() {
			const me = this;

			me._load();
		},
		_load: function(){
			const me = this,
						randomBox1 = me.selectors.random1,
						randomBox2 = me.selectors.random2;

			const randomItem1 = document.querySelectorAll(randomBox1 + ' > .item'),
						randomItem2 = document.querySelectorAll(randomBox2 + ' > .item');

			randomItem1.forEach( (e) => {
				let randomNumber = Math.floor(Math.random() * randomItem1.length) + 1;
				e.style.order = randomNumber;
			});

			randomItem2.forEach( (e, i) => {
				e.style.order = randomItem1[i].style.order;
			});

			let itemArray = [],
					itemArray2 = [];

			for( let i = 1; i <= randomItem1.length ;i++){
					randomItem1.forEach( (e) => {
							if( e.style.order == i ){
									itemArray.push(`${e.outerHTML}`);
									return;
							}
					});

					randomItem2.forEach( (e) => {
							if( e.style.order == i ){
									itemArray2.push(`${e.outerHTML}`);
									return;
							}
					});
			}

			document.querySelector(randomBox1).innerHTML = `${itemArray.join("")}`;
			document.querySelector(randomBox2).innerHTML = `${itemArray2.join("")}`;
		}
	};

	window.randomInsert = randomInsert;
}(window));

/* footer family */
(function (window, undefined) {
	"use strict";
	/**
	 * @description footer family
	 * @modify
			@20230000 추가
	*/
	var footerFamily = {
		/** 플러그인명 */
		bind: footerFamily,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			family: '[data-event="family"]'
		},
		initialize: function() {
			const me = this;

			me._click();
		},
		_click: function(){
			const me = this,
						family = me.selectors.family;

			document.querySelector(family + ' button').onclick = (e) => {
				e.target.parentElement.classList.toggle('is-open');
			}

			window.addEventListener('click', (e) => {
				if( !e.target.classList.contains('button') ){
					document.querySelector(family + ' .dropdown').classList.remove('is-open');
				}
			})
		}
	};

	window.footerFamily = footerFamily;
}(window));

/* scrollSticky */
(function (window, undefined) {
	"use strict";
	/**
	 * @description scrollSticky
	 * @modify
			@20230000 추가
	*/
	var scrollSticky = {
		/** 플러그인명 */
		bind: scrollSticky,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			itemFx: '[data-event="header"]'
		},
		initialize: function() {
			const me = this;

			me._scroll();
		},
		_scroll: function(){
			const me = this,
						itemFx = me.selectors.itemFx;

			let itemFxItem = document.querySelector(itemFx),
					itemFxTop = itemFxItem.offsetTop;

			window.onresize = () => {
				itemFxTop = itemFxItem.offsetTop;
			}

			window.onscroll = (e) => {
				let windowScrollTop = window.scrollY;

				if( itemFxTop <= windowScrollTop ){
					itemFxItem.classList.add('is-fixed');
				}else{
					itemFxItem.classList.remove('is-fixed');
				}
			}
		}
	};

	window.scrollSticky = scrollSticky;
}(window));