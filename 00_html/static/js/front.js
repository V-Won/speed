if (window.console == undefined) { console = { log: () => { } } }

/* device */
(function (window, undefined) {
	"use strict";
	/**
	 * @description device 분기
	 * @modify
	*/
	var device = {
		/** 플러그인명 */
		bind: device,
		initialize: function () {
			const me = this;

			me._resize();
		},
		_resize: () => {
			const body = document.querySelector('body');

			const deviceCall = () => {
				window.innerWidth < 1024 ? ( // mobile
					body.classList.remove('pc'),
					body.classList.add('mobile')
				) : ( // pc
					body.classList.remove('mobile'),
					body.classList.add('pc')
				)
			}

			deviceCall();

			window.addEventListener('resize', () => {
				deviceCall();
			})
		}
	};

	window.device = device;
}(window));

/* header */
(function (window, undefined) {
	"use strict";
	/**
	 * @description header
	 * @modify
	*/
	var header = {
		/** 플러그인명 */
		bind: header,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			// 비동기 selector 사용 금지
		},
		initialize: function () {
			const me = this;

			me._scroll();
			me._hover();
			me._click();
		},
		_hover: () => {
			const headerGnb = '.box-header';
		},
		_scroll: () => {
			const boxHeader = document.querySelector('.box-header');
		},
		_click: () => {
			const me = this,
				tg = '.hamburger';
		}
	};

	window.header = header;
}(window));

// Footer
(function (window, undefined) {
	"use strict";
	/**
	 * @description Footer
	 * @modify
	*/
	var footer = {
		/** 플러그인명 */
		bind: footer,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			// 비동기 selector 사용 금지
		},
		initialize: function () {
			const me = this;

			me._click(); // family
		},
		_click: () => {
			const tg = '[data-event="selectBox"]',
				selectBoxs = document.querySelectorAll(tg);
		}
	};

	window.footer = footer;
}(window));

/* selectBox */
(function (window, undefined) {
	"use strict";
	/**
	 * @description selectBox
	 * @modify
	*/
	var selectBox = {
		/** 플러그인명 */
		bind: selectBox,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="commonSelectBox"]'
		},
		initialize: function () {
			const me = this;

			me._click();
		},
		_click: function () {
			const me = this,
				tg = me.selectors.tg;

			const selectBoxs = document.querySelectorAll(tg);

			for (const selectBox of selectBoxs) {
				selectBox.querySelector(tg + ' > .button').addEventListener('click', (e) => {
					let parent = e.target.parentElement;
					e.preventDefault()

					if (!parent.classList.contains('is-active')) {

						selectBoxs.forEach(e => {
							if (e.classList.contains('is-active')) {
								e.classList.remove('is-active');
							}
						});

						if (!parent.classList.contains('disabled')) {
							parent.classList.add('is-active');
						}
					} else {
						parent.classList.remove('is-active');
					}
				})
			}

			document.querySelectorAll(tg + ' > ul > li button').forEach(e => {
				e.onclick = () => {
					e.parentNode.parentNode.parentNode.querySelector(tg + ' > .button').innerText = e.innerText;
					e.parentNode.parentNode.parentNode.classList.add('font');

					document.querySelectorAll(tg + ' > ul > li').forEach((e) => {
						e.classList.remove('is-active');
					});
					e.parentNode.classList.add('is-active');
				}
			});

			window.addEventListener('click', (e) => {
				if (!e.target.classList.contains('button')) {
					selectBoxs.forEach(e => {
						e.classList.remove('is-active');
					});
				}
			})
		}
	};

	window.selectBox = selectBox;
}(window));

/* file Delete */
(function (window, undefined) {
	"use strict";
	/**
	 * @description file Delete
	 * @modify
	*/
	var fileDelete = {
		/** 플러그인명 */
		bind: fileDelete,
		/** 기본 옵션값 선언부 */
		defaults: {
		},
		/** selector 선언부 */
		selectors: {
			tg: '[data-event="fileDelete"]'
		},
		initialize: function () {
			const me = this;

			me._click();
		},
		_click: function () {
			const me = this,
				tg = me.selectors.tg;

			const delBtns = document.querySelectorAll(tg + ' .del-btn');

			for (const delBtn of delBtns) {
				delBtn.addEventListener('click', (e) => {
					// class remove					
					e.target.parentNode.parentNode.querySelectorAll('.file-item > li').forEach(() => {
						e.target.parentNode.remove();
					})
				})
			}
		}
	};

	window.fileDelete = fileDelete;
}(window));

/* checkboxAll */
(function (window, undefined) {
	"use strict";
	/**
	 * @description checkboxAll
	 * @modify
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
		initialize: function () {
			const me = this;

			me._click();
		},
		_click: function () {
			const me = this,
				tg = me.selectors.tg,
				tg2 = me.selectors.tg2;

			let ck = (st, item) => {
				st == "on" ? item.checked = true : item.checked = false;
			}

			document.querySelectorAll(tg + ' input').forEach(e => {
				e.onclick = (e) => {
					document.querySelectorAll('input[name="' + e.target.name + '"]').forEach(item => {
						e.target.checked ? ck('on', item) : ck('off', item);
					});
				}
			});

			document.querySelectorAll(tg2 + ' input').forEach(e => {
				e.onclick = (e) => {
					if (document.querySelectorAll('[data-event="checkbox"] input[name="' + e.target.name + '"]').length == document.querySelectorAll('[data-event="checkbox"] input[name="' + e.target.name + '"]:checked').length) {
						ck('on', document.querySelector('[data-event="checkboxAll"] input[name="' + e.target.name + '"]'));
					} else {
						ck('off', document.querySelector('[data-event="checkboxAll"] input[name="' + e.target.name + '"]'));
					}
				}
			});
		}
	};

	window.checkboxAll = checkboxAll;
}(window));

/* Layer popup */
(function (window, undefined) {
	"use strict";
	/**
	 * @description Layer popup
	 * @modify
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
			closeBtn: '[data-event="layerClose"]'
		},
		initialize: function () {
			let me = this;

			me._click();
		},
		_click: function () {
			const me = this,
				openBtn = me.selectors.openBtn,
				closeBtn = me.selectors.closeBtn;

			const openBtns = document.querySelectorAll(openBtn),
				closeBtns = document.querySelectorAll(closeBtn);

			for (const tg of openBtns) {
				tg.onclick = e => {
					let currentTarget = e.currentTarget.getAttribute('data-layerId');

					//document.querySelector('#' + currentTarget).style.display = 'block';
					document.querySelector('#' + currentTarget).classList.add('show');
					document.querySelector('#' + currentTarget).scrollTo(0, 0);
					document.body.classList.add('on');
				}
			};

			for (const tg of closeBtns) {
				tg.onclick = e => {
					layerClose();
				}
			};

			document.querySelectorAll('.box-layer').forEach(e => {
				e.onclick = e => {
					if (e.target.classList.contains('box-layer')) {
						layerClose();
					}
				}
			});

			const layerClose = function () {
				document.querySelectorAll('.box-layer').forEach(e => {
					e.classList.remove('show');
				});

				document.body.classList.remove('on');
			}
		}
	};

	window.layerPopup = layerPopup;
}(window));

/**
 * front.js 하단에 위치
 */
//  XMLHttpRequest js 에서 가져오는 DOM 관련 이벤트는 onload에 넣기.
window.addEventListener('load', () => {
	setTimeout(() => {
		header.initialize();
		footer.initialize();

		// 마우스커서
		gsap.set(".window-cursor", { xPercent: -50, yPercent: -50 });

		const Tc = document.querySelector(".window-cursor"),
			Pc = document.querySelectorAll("a, button");

		let xTo = gsap.quickTo(".window-cursor", "x", { duration: 0.6, ease: "power3" }),
			yTo = gsap.quickTo(".window-cursor", "y", { duration: 0.6, ease: "power3" });

		window.addEventListener("mousemove", e => {
			xTo(e.clientX);
			yTo(e.clientY);
		});

		document.addEventListener("mouseenter", (function () {
			Tc.style.opacity = 1
		}
		));
		document.addEventListener("mouseleave", (function () {
			Tc.style.opacity = 0
		}
		));

		// a button hover
		Pc.forEach((e) => {
			if (e.classList.contains('not-cursor')) {
				e.addEventListener("mouseover", (function () {
					Tc.style.display = 'none';
				}));
				e.addEventListener("mouseleave", (function () {
					Tc.style.display = 'block';
				}));
			}
			e.addEventListener("mouseover", (function () {
				Tc.classList.add('link-over');
			}));
			e.addEventListener("mouseleave", (function () {
				Tc.classList.remove('link-over');
			}));
		});

		// main swiper-button hover
		let swiperPrev = document.querySelector('.box-main-kv .swiper-button-prev'),
			swiperNext = document.querySelector('.box-main-kv .swiper-button-next');

		if (document.querySelectorAll('.box-main-kv').length) {
			swiperPrev.addEventListener('mouseover', () => {
				Tc.classList.add('main-swiperButton-prev');
			})
			swiperPrev.addEventListener('mouseleave', () => {
				Tc.classList.remove('main-swiperButton-prev');
			})
			swiperNext.addEventListener('mouseover', () => {
				Tc.classList.add('main-swiperButton-next');
			})
			swiperNext.addEventListener('mouseleave', () => {
				Tc.classList.remove('main-swiperButton-next');
			})
		}
		// //마우스커서

		// button hover animate
		class Button {
			constructor(buttonElement) {
				this.block = buttonElement;
				this.init();
				this.initEvents();
			}

			init() {
				const el = gsap.utils.selector(this.block);

				this.DOM = {
					button: this.block,
					flair: el(".circle"),
					text: el(".button__label")
				};

				this.xSet = gsap.quickSetter(this.DOM.flair, "xPercent");
				this.ySet = gsap.quickSetter(this.DOM.flair, "yPercent");
				this.hasFill = this.DOM.button.classList.contains("button--fill");
			}

			getXY(e) {
				const { left, top, width, height } =
					this.DOM.button.getBoundingClientRect();

				const xTransformer = gsap.utils.pipe(
					gsap.utils.mapRange(0, width, 0, 100),
					gsap.utils.clamp(0, 100)
				);

				const yTransformer = gsap.utils.pipe(
					gsap.utils.mapRange(0, height, 0, 100),
					gsap.utils.clamp(0, 100)
				);

				return {
					x: xTransformer(e.clientX - left),
					y: yTransformer(e.clientY - top),
				};
			}

			initEvents() {
				this.DOM.button.addEventListener("mouseenter", (e) => {
					gsap.fromTo(this.DOM.text, {
						color: "#FFFCE1"
					}, {
						color: "#000",
						duration: 1,
						ease: "power2.out"
					});

					const { x, y } = this.getXY(e);

					this.xSet(x);
					this.ySet(y);

					if (this.hasFill) {
						gsap.to(this.DOM.flair, {
							opacity: 1,
							duration: 1,
							ease: "power2.out",
						});

					} else {
						gsap.to(this.DOM.flair, {
							scale: 1,
							duration: 0.4,
							ease: "power2.out",
						});
					}
				});

				this.DOM.button.addEventListener("mouseleave", (e) => {
					const { x, y } = this.getXY(e);

					gsap.killTweensOf(this.DOM.flair);

					if (this.hasFill) {
						gsap.to(this.DOM.flair, {
							xPercent: x > 90 ? x + 20 : x < 10 ? x - 20 : x,
							yPercent: y > 90 ? y + 20 : y < 10 ? y - 20 : y,
							opacity: 0,
							duration: 1,
							ease: "power2.out",
						});

					} else {
						gsap.to(this.DOM.flair, {
							xPercent: x > 90 ? x + 20 : x < 10 ? x - 20 : x,
							yPercent: y > 90 ? y + 20 : y < 10 ? y - 20 : y,
							scale: 0,
							duration: 0.3,
							ease: "power2.out",
						});
						gsap.fromTo(this.DOM.text, {
							color: "#000"
						}, {
							color: "#FFFCE1",
							duration: 1,
							ease: "power2.out"
						});
					}
				});

				this.DOM.button.addEventListener("mousemove", (e) => {
					const { x, y } = this.getXY(e);

					gsap.to(this.DOM.flair, {
						xPercent: x,
						yPercent: y,
						duration: this.hasFill ? 1 : 0.4,
						ease: "power2",
					});
				});
			}
		}

		const buttonElements = document.querySelectorAll('[data-block="button"]');

		buttonElements.forEach((buttonElement) => {
			new Button(buttonElement);
		});
		// //button hover animate
	}, 300)
})

// 공통 js 호출
device.initialize();