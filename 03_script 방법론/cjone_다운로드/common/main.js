(function ($, core, undefined) {
	/**
	* @description 메인 처리용 스크립트 
	* @class
	* @name cjone.ui.MainUI
	* @extends cjone.ui.View
	* @example
	*		<a href="http://dev.cjone.com:8001/cjmweb/front/main/MA_010.html" target="_blank">http://dev.cjone.com:8001/cjmweb/front/main/MA_010.html<a/><br/><a href="http://dev.cjone.com:8001/cjmweb/front/main/MA_020.html" target="_blank">http://dev.cjone.com:8001/cjmweb/front/main/MA_020.html</a>
	*	*/
	var $doc = $(document),
          $win = $(window);
	var mainUI = core.ui('MainUI', /**@lends cjone.ui.MainUI */{
		/** jquery 플러그인명  */
		bindjQuery: 'mainUI',
		/**	기본 옵션값 선언부	*/
		defaults: {
		},
		/**	
		 * selector 선언부		
		 * */
        selectors: {
			promotion: '[data-control="promotion"]',
			hotItem: '[data-control="hotItem"]',
			recommend: '[data-control="recommend"]',

			quick: '[data-control="quick"]',
			alliance: '[data-control="alliance"]',
			scrollAction : '[data-control="scrollAction"]',
			circleMotion: '[data-control="circleMotion"]'			//bg에 보이는 circle
        },
        
		/**
         * 생성자
         * @constructors
         * @param {String|Element|jQuery} el
         * @param {Object} options
         */
		initialize: function (el, options) {
			var me = this;
			if (me.supr(el, options) === false) { return; }

			me._promotionArea();
			me._recommendArea();
			me._hotItemArea();
			me._quickArea();
			me._allianceArea();
			me._circleMotionArea();
			me._setUp();
			me._bindEvents();
			
			if(me.$recommend.size() == 0)			me.$scrollAction.scrollAction({margin: 240});
			
			//추천서비스 영역이 열리고 난후 callback되는 함수
			me.$circleMotion.on({
				'open:recommend': function () {}
			});
		},
		
		/**
		 * HotItem 영역 좌/우의 원형 이미지의 스크롤 이벤트 처리
		 * @callback {Object} type:circle - 스크롤이 이벤트 발생시 callback 처리되는 부분
		 * @private
		 *  */
		_circleMotionArea: function () {
			var me = this,
				  recommendHeight = (me.$recommend.height() || 0),
				  $items = me.$circleMotion.children(),
				  $doughnutR = $items.filter('.doughnut_r'),
				  $combineR = $items.filter('.combine_r'),
				  $doughnutL = $items.filter('.doughnut_l'),
				  $combineL = $items.filter('.combine_l'),
				  $posi3 = $items.filter('.posi3'),
				  $posi4 = $items.filter('.posi4');

			$items.each(function () {
				var $this = $(this);
				$this.attr('data-before', $this.position().top);
			});
			
			var checkDoughnutR = function ($el) {
				if(!$el.is($doughnutR)) return;
				var _doughnutR = parseFloat($doughnutR.attr('data-before')),
					  _combineR = parseFloat($combineR.attr('data-before')),
					  r = ((cjone.$win.scrollTop()+_doughnutR)-recommendHeight)*1.3,
					  isJoin = false;
				
				isJoin = (r-(_combineR) >= 0);
				
				if(isJoin == true){
					r = ((cjone.$win.scrollTop()-recommendHeight) < r-50? r/1.6: _combineR);
				}
				
				$doughnutR.css({							top: r						});
				$combineR.css({							top: (isJoin == true ? r : _combineR)						});
			};
			
			$items.on({
				'type:circle': function (e, dataSet) {
					var $el = dataSet.$el,
						  $this = $el;
						  
					checkDoughnutR($el);
					
					var _doughnutL = parseFloat($doughnutL.attr('data-before')),
						  r = (((cjone.$win.scrollTop()-cjone.util.getWinHeight())-recommendHeight)+_doughnutL)*1.3;
					$doughnutL.css({							top: r						});
					
					
					var _combineL = parseFloat($combineL.attr('data-before')),
					r = ((cjone.$win.scrollTop()-$combineL.height())-recommendHeight);
					r = (r>_combineL+500 ? r/1.6: _combineL);
					$combineL.css({							top: r						});
					
					
					var _combineL = parseFloat($combineL.attr('data-before')),
					r = ((cjone.$win.scrollTop()-$combineL.height()))-recommendHeight;
					r = (r>_combineL+500 ? r/1.6: _combineL);
					$combineL.css({							top: r						});
					
					var _posi3 = parseFloat($posi3.attr('data-before')),
					//r = _posi3;
					r = (cjone.$win.scrollTop()+recommendHeight > _posi3 ? (_posi3+(_posi3-(cjone.$win.scrollTop())))+recommendHeight: _posi3);
					$posi3.css({							top: r						});
					
					var _posi4 = parseFloat($posi4.attr('data-before')),
					r = (cjone.$win.scrollTop()+recommendHeight > _posi4 ? (_posi4+(_posi4-(cjone.$win.scrollTop())))+recommendHeight: _posi4);
					$posi4.css({							top: r						});					
				}
			});
		},
		
		/**
		 * 제휴브랜드 영역
		 * @private
		 *  */
		_allianceArea: function () {
			var me = this;
			
			me.$alliance.find('[data-control="tab"]').tab().on({
				'tab:changed': function (e, dataSet) {
					var $el = dataSet.sender,
						  selectedIndex = dataSet.selectedIndex;
				}
			});
			
			var $allianceList = me.$alliance.find('[data-handler="allianceList"]').on({
				'open close': function (e) {
					var $this = $(this),
						  $parent = $this.parent().toggleClass('on'),
						  type = e.type;
						  
					$this.closest($allianceList).find('a').parent().not($parent).removeClass('on');
					
					var $detailInfo = $parent.find('.detail_info').css({
						'opacity': 0,
						'left': 0
					});
					var left = $detailInfo.width(),
						  left = (cjone.getScreenStatus() != 'small' && $allianceList.find('a').index($this)%6 == 5 ? left*-1: left),		//768 이상 해상도
						  left = (cjone.getScreenStatus() == 'small' && $allianceList.find('a').index($this)%4 == 3 ? left*-1: left);		//768 이상 해상도
					
					switch(type){
						case 'open':
							$detailInfo.animate({
								'opacity': 1,
								'left': left
							}, 350, 'easeOutQuart');
						break;
					}
				},
				'mouseenter focus': function () {
					if(cjone.browser.isDevice == true) return;
					var $this = $(this);
					$this.trigger('open');
				},
				'mouseleave blur': function () {
					if(cjone.browser.isDevice == true) return;
					var $this = $(this);
					$this.trigger('close');
				},
				'click': function (e) {
					if(cjone.browser.isDevice == false)return;
					var $this = $(this),
						  isOpen = $this.parent().hasClass('on');
						  
					if(isOpen == false) e.preventDefault();
					$this.trigger((isOpen == false? 'open': 'close'));
				}
			}, 'a');
		},
		
		/**
		 * 퀵메뉴 영역
		 * @callback {Object} type:motion - 스크롤 이벤트가 발생했을 경우 callback
		 * @private
		 *  */
		_quickArea: function () {
			var me = this;
			
			var runSeqs = function () {
				//시퀀스 이미지용
				var $seqs = me.$quick.find('[data-start-num]').each(function () {
					var $this = $(this);
				  	$this.sequenceMotion('start');
				});	
			};
			
			var $scrollAction = me.$quick.find('[data-scroll-callback]').on({
				'type:motion': function (e, dataSet) {
					var $el = dataSet.data.$el;
					var r = (cjone.$win.scrollTop()+cjone.util.getWinHeight())-($el.offset().top+$el.outerHeight(true));
					if(r>0 && cjone.$win.scrollTop() < $el.offset().top){
						if(!$el.attr('scrollInAction')){
							runSeqs();
							$el.attr('scrollInAction', 'complete');
						}
					}else{
						$el.removeAttr('scrollInAction');
					}
				}
			});
			
			me.$quick.find('[data-start-num]').parent('a').on({
				'mouseenter': function () {
					var $this = $(this);
					$this.children().sequenceMotion('start');
				}
			});
		},
		
		/**
		 * 추천 서비스 영역
		 * @private
		 * @callback {Object} goto:start - 로그인후 추천서비스를 열때 사용
		 * @callback {Object} open - 로그인후 추천서비스 영역으로 스크롤 이동시키기 위해 사용
		 * @description
		 		bxslider 플러그인 사용
		 *  */
		_recommendArea: function () {
			var me = this,
				  $obj = me.$recommend.find('[data-control="banner"]'),
				  $wrap = $obj.find('.list_wrap');
				  
			var recommendBanner = function () {
				var $recommendBanner = null;
				var $btns = $obj.find('.btn_prev, .btn_next');
				var checkBtns = function (currentIndex) {
					var isPrev = (currentIndex == 0),
				    	  isNext = ($obj.find('.bx-pager>').size() == currentIndex+1);
					$btns.filter('.btn_prev')[isPrev == false? 'removeClass': 'addClass']('hide');
				    $btns.filter('.btn_next')[isNext == false? 'removeClass': 'addClass']('hide');
				};
				var sliderOptions = {
					maxSlides: 6,
					slideMargin: 0,
					startSlide: 0,  
					auto: false,
		            autoControls: false,
		            controls: false,
		            infiniteLoop: true,
		            speed: 800,
					onSlideAfter: function ($el, oldIndex, currentIndex) {
					},
				    onSlideBefore: function ($el, oldIndex, currentIndex) {
				    	checkBtns(currentIndex);
				    },
			    	onSlidePrev: function ($el, oldIndex, currentIndex) {				    },
					onSliderLoad: function (currentIndex) {				
						$obj.find('.bx-pager').addClass('hide');
						var me = this,
							  $clone = $obj.find('.'+me.wrapperClass).find('.bx-clone').addClass('js_vhidden'),
							  $list = $clone.siblings().not('.bx-clone');
							  r = $list.last().offset().left+$list.last().width();
							  
						r = (r > $wrap.parent().width());
						
						$btns.filter('.btn_prev').addClass('hide');
						$btns.filter('.btn_next')[(r == true ? 'removeClass': 'addClass')]('hide');
					}
				};
				
				$recommendBanner = $wrap.bxSlider(sliderOptions);
				checkBtns(0);
				
				$btns.on({
					'click': function (e) {
						e.preventDefault();
						var $target = $(e.target);
						$recommendBanner[($target.hasClass('btn_next') == true ? 'goToNextSlide': 'goToPrevSlide')]();
					}
				});
				return {
					$recommendBanner: $recommendBanner,
					sliderOptions: sliderOptions
				};
			};
			
			var sliderOptions = null,
				  motionSet = function (isOpen) {
						sliderOptions = recommendBanner();
				  	
						me.$recommend[(isOpen == true ? 'addClass': 'removeClass')]('on');
						me.$recommend.find('[data-handler="infoWrap"]').addClass('on');
						me.$recommend.find('.bx-pager').addClass('hide');
						
						if(cjone.browser.isDevice == true){
							me.$recommend.find('.btn_arrow').hide();
						}
						
						$wrap.css({
							'top': '10%',
							'opacity': 0
						}).animate({
							'top': '0',
							'opacity': 1
						}, {
							duration: 1000,
							complete: function (){
								$('[data-control="randomNum"]').charMotion('runUp');
								me.$scrollAction.scrollAction({margin: 240});
								me._circleMotionArea();
								me.$circleMotion.triggerHandler('open:recommend');
								
								var flag = (cjone.browser.isChrome == true || cjone.browser.isSafari == true);
								$((flag == true ? 'body': 'html')).smoothWheel();
							}
						});
				  };
			
			me.$recommend.on({
				'goto:start': function (e) {
					var posY = me.$recommend.show().offset().top;
					if(cjone.$win.scrollTop() == 0){
						setTimeout(function () {
							cjone.util.scrollToElement(me.$recommend, {duration: 1000});
						}, 1000);
					}
				},
				'open close': function (e) {
					var isOpen = (e.type == 'open'? true: false);
						  //flag = false;
					
					if(isOpen == true){
						var pluginTimer = setInterval(function () {
							if(typeof $.fn.smoothWheel == 'function'){
								clearTimeout(pluginTimer);
								motionSet(isOpen);
							}
						}, 10);
					}
				}
			});
			
			$wrap.on({
				'update': function () {			//추천 서비스 영역의 더보기 @deprecated
					sliderOptions.sliderOptions.startSlide = sliderOptions.$recommendBanner.getCurrentSlide();
					$wrap.reloadSlider(sliderOptions.sliderOptions);
				}
			});
		},
		
		/**
		 * HotItem 영역의 요소들을 재정렬하는 함수
		 * @deprecated
		 *  */
		_setHotItemPos: function () {
			var me = this;
		},
		
		/**
		 * 뜨거운 아이템 영역
		 * 마우스+키보드 focus, blur시 on 클래스
		 * @callback {Object} type:vertical - blog 영역에 대한 스크롤 callback
		 * @private
		 *  */
		_hotItemArea: function () {
			var me = this,
				  $hotItem = me.$hotItem,
				  $itemsA = null,
				  $itemDetail = null;
				  
			me._setHotItemPos();
				  
			//mouse, focus 되었을때의 이벤트 처리
	        $itemsA = $hotItem.find('.item_link').on({               //링크에 focus 되었을때
	        	'focused': function () {
	                var $this = $(this);
					$this.next().triggerHandler('open');
	            },
	            'blured': function () {
	                var $this = $(this);
	                $itemsA.removeClass('focus').next().triggerHandler('close');
	            },
	            'focus:on hover:on': function (e) {
	                e.preventDefault();
	                $(this).triggerHandler('focused');
	            },
	            'click': function (e) {
	            	e.preventDefault();
	            }
	        });
	       
	        $itemDetail = $itemsA.siblings('.item_detail').on({
	        	'open': function () {
	        		var $this = $(this);
	        		$itemDetail.not($this.addClass('on')).removeClass('on');
	        	},
	        	'close': function () {
	        		$itemDetail.removeClass('on');
	        	}
	        });

			//키보드 접근성을 처리하기 위한 부분
	        $itemsA.on({
	        	'keydown': function (e) {
	        		if(e.keyCode != 9) return;
	        		
	        		var $this = $(this),
	        			  selectedIndex = $itemsA.index($this);
	        			  
	        		switch(e.shiftKey){
	        			case false:
	        				e.preventDefault();
		        			$this.next().trigger('open');
	        				$this.next().find('a, button').last().focus();
	        			break;
	        			case true:
	        				if(selectedIndex == 0){
	        					$itemDetail.triggerHandler('close');
	        					return;
	        				}	
	        				e.preventDefault();
	        				var $_next = $itemsA.eq(selectedIndex-1).next(); 
							$_next.trigger('open');
							$_next.find('a, button').last().focus();
	        			break;
	        		}
	        	},
	        	'keyup': function (e) {
	        		var $this = $(this),
	        			  selectedIndex = $itemsA.index($this);
	        		if(selectedIndex+1 == $itemsA.size()){
	        			$this.next().find('a, button').last().focus();
	        		}
	        	}
	        });
	        
	        //키보드 접근성을 처리하기 위한 부분
	        $itemDetail.find('a').on({
	        	'keydown': function (e) {
	        		if(e.keyCode != 9)	return;
	        		
	        		var $this = $(this),
	        			  selectedIndex = $itemDetail.index($this.closest($itemDetail));
	        			  
	        		switch(e.shiftKey){
	        			case false:
	        				if(selectedIndex == $itemsA.size()-1){
	        					$itemDetail.triggerHandler('close');
	        					return;
	        				}
	        				e.preventDefault();
	        				var $_next = $itemsA.eq(selectedIndex+1);
	        				$_next.focus();
	        			break;
	        			case true:
	        				e.preventDefault();
	        				$itemsA.eq(selectedIndex).focus().removeClass('focus');
	        				$itemDetail.eq(selectedIndex).triggerHandler('close');
	        			break;
	        		}
	        	}
	        });
	        
	        //열려있던 레이어에서 blur 되었을때
	        $hotItem.find('.item_detail, .hot_item').on({
	            'mouseleave blur': function (e) {
	                $itemsA.triggerHandler('blured');
	            }
	        });
	       	        
	        //스크롤 기반의 좌/우 circle 배경의 위치값 재설정
	        var $hotItemCallbacks = $hotItem.find('[data-scroll-callback]');
	        var scrollCallbackArray = {
	        	'big': [
	        		200, 0
	        	],
	        	'medium': [
	        		50, 86
	        	],
	        	'small': [
	        		200, 0
	        	]
	        };
	        
	        $hotItemCallbacks.eq(0).attr('data-limit-top', scrollCallbackArray[cjone.getScreenStatus()][0]);
	        $hotItemCallbacks.eq(1).attr('data-limit-top', scrollCallbackArray[cjone.getScreenStatus()][1]);
	        
	        $hotItem.find('[data-scroll-callback]').on({
				'type:vertical': function (e, dataSet) {
					switch(cjone.getScreenStatus()){
						case 'medium':
						case 'small':
							return;
						break;
					}
		        	var $this = dataSet.$el,
		            	  limit = parseFloat($this.attr('data-limit-top').replace(/\s|\D/gi, ''));	
		            	  
					if(!$this.attr('data-before'))  $this.attr('data-before', $this.offset().top);
					
		            var stand = parseFloat($this.attr('data-before')),
		            	  r = cjone.$win.scrollTop() >= stand && cjone.$win.scrollTop() <= stand+limit,
		            	  r = (r == true ? cjone.$win.scrollTop() : $this.offset().top);
		            $this.offset({top: r});
				},
				'scroll-callback': function (e, dataSet) {
					var $this = dataSet.$el;
				}
	        });
	        
	        {
	        	/**
	         	* 가로형 배너의 margin-top 구하기
	         	* 가로형: summarty_info
	         	* detail_wrap
	         	*  */
				var $hotItemSummaryInfo = $('.hot_item.col .summary_info');
				$hotItemSummaryInfo.each(function () {
					var $this = $(this);
					$this.css({				    	'margin-top': ($this.height()/2)*-1					});
				});
				
				//detail_wrap의 텍스트 높이값 세팅
				var $hotItemDetailWrap = $('.detail_wrap');
				$hotItemDetailWrap.each(function () {
					var $this = $(this);
					
					$this.parent().addClass('on');
					var marginTop = ($this.height()/2)*-1;
					$this.css({						'margin-top': marginTop					});
					$this.parent().removeClass('on');
				});
			}
		},

		/**
		 * 프로모션 영역 배너
		 * @private
		 * @description
		 		bxslider 사용
		 *  */
		_promotionArea: function () {
			var me = this,
				  $promotionBanner = me.$promotion.find('[data-handler="banner"]'),
				  $promotionBannerList = $promotionBanner.children(),
				  $promotionBxSlider = null,
				  bgColor = me.$promotion.attr('data-indicator-color').replace(/\s/gi, '');
				  
			$promotionBxSlider = $promotionBanner.bxSlider({
				auto: ($promotionBannerList.size() >1 ? true: false),
				infiniteLoop: true,
				speed: 1500,
				pause: 6000,
				autoHover: true,
				autoControls: true,
				startSlide: 0,
				touchEnabled: ($promotionBannerList.size() >1 ? true: false),
				removeWidth: false,
				onSlideAfter: function ($el, oldIndex, currentIndex) {
					setTimeout(function () {
						$promotionBannerList.not($el.addClass('on')).removeClass('on');
					}, 500);					
				},
				onSlideBefore: function ($el, oldIndex, currentIndex) {
					me.$promotion.children().removeClass('white black').addClass(bgColor.split(',')[currentIndex]);
				},
				onSliderLoad: function (currentIndex) {
					me.$promotion.children().removeClass('white black').addClass(bgColor.split(',')[0]);
					$promotionBannerList.eq(currentIndex).addClass('on');
				}
			});
			
			
			/**
			 * css애니메이션 이벤트가 끝났을 경우 callback
			 * @deprecated
			 *  */
			$promotionBannerList.on({
				'msAnimationEnd animationend transitionend': function () {
					//$promotionBannerList.removeClass('on');
				}
			});
			
			var $slider = $promotionBxSlider.getSlider();
			$slider.controls.prev[($promotionBannerList.size() <= 1 ? 'addClass': 'removeClass')]('hide');
			$slider.controls.next[($promotionBannerList.size() <= 1 ? 'addClass': 'removeClass')]('hide');
			
			//태블릿이고 1024 사이즈 보다 작을 경우 좌우 이동 버튼 숨김처리
			if(cjone.browser.isDevice && cjone.util.getWinWidth() < 1024)			me.$promotion.find('.bx-controls').hide();
			
			$win.on('resize', function () {
				$win.triggerHandler('slider.resize');
			});
		},
		
		/**
		* 스크롤을 부드럽고 자연스럽게 처리하기 위한 플러그인 이벤트 셋업
		* @private
		*/
		_setUp: function () {
			var me = this;

			var asFront = (cjone.uri.parseUrl(location.href).directory.indexOf('/cjmweb/front') > -1 ? 'front/': '' );
			cjone.importJs(['/cjmweb/'+(asFront)+'js/modules/jquery.smoothwheel'], function () {
				var flag = (cjone.browser.isChrome == true || cjone.browser.isSafari == true);
				$((flag == true ? 'body': 'html')).smoothWheel();
			});
		},
       
		/**
		 * 이벤트 바인딩
		 * @private
		 */
		_bindEvents: function () {
			var me = this;
        }
	});

    if (typeof define === "function" && define.amd) {
		define([], function() {
			return HeaderUI;
		});
	}
})(jQuery, window[LIB_NAME]);




(function ($, core, undefined) {
	/**
	* @description 메인 HotItem영역의 요소들의 위치값을 해상도별 재정의하는 모듈	  *
	* @class
	* @name cjone.ui.MainHotItem
	* @extends cjone.ui.View
	* @example <br/><br/><a href="http://dev.cjone.com:8001/cjmweb/front/main/MA_010.html" target="_blank">http://dev.cjone.com:8001/cjmweb/front/main/MA_010.html<a/><br/><a href="http://dev.cjone.com:8001/cjmweb/front/main/MA_020.html" target="_blank">http://dev.cjone.com:8001/cjmweb/front/main/MA_020.html</a><br/><br/>
	*	*/
    core.ui('MainHotItem', /**@lends cjone.ui.MainHotItem*/{
		/** jquery 플러그인명  */
        bindjQuery:'mainHotItem',
        $statics: {
            ON_CLICK: 'click'
        },
        /**	기본 옵션값 선언부	*/
        defaults: {
            marginTop: 0,
            marginLeft: 0,
            type: 'default'
        },
        /**	selector 선언부		*/
        selectors: {
            slide: '.hot_item'
        },
		/**
         * 생성자
         * @constructors
         * @param {String|Element|jQuery} el
         * @param {Object} options
         * @param {Boolean}  options.marginTop - 요소에 대한 marginTop
         * @param {Boolean}  options.marginLeft - 요소에 대한 marginLeft
         * @param {Boolean}  options.type
         */        
        initialize: function (el, options) {
            var me = this;
            if(me.supr(el, options) === false) { return; }
            
            me._bindEvent();
        },
        /**
         * 일정 해상도 이하로 내려갔을 때 Object들의 높이값을 재 수정
         * @private
         * @example
         		RePositionSelf._rePositionCell();
         *  */
        _rePositionCell: function (e, data) {
        	var me = this;
        	
        	me.$el.height('auto');
        	me.$slide.removeAttr('style').each(function (idx) {
            	var $this = $(this);
            	$this.css({
            		'top': $this.position().top,
            		'left': $this.position().left	
            	});
            }).parent().removeAttr('style');
            
            /**
             * 6, 7번 요소의 위치값에 따라 9번의 위치값을 설정함
             * @inner
             *  */
            var checkHeight = function ($el1, $el2) {
            	if($el1.position().top+$el1.height() > $el2.position().top+$el2.height()){
            		return $el1;
            	}else{
            		return $el2;
            	}
            },
            /**
             * 요소들의 위치값을 설정후 해당 요소를 리턴
             * @inner
             *  */
            repositionEl = function ($el, opts) {
            	if(opts){
	            	for(var key in opts){
						opts[key] = opts[key].position()[key]+opts[key][(key == 'top'? 'outerHeight': 'outerWidth')](true);
					}
					$el.css(opts);
				}
				return $el;
            },
            resetPosition = {
            	'big': function (callback) {
            		me.$slide.css({'position': 'absolute'});
            		repositionEl(me.$slide.eq(4), {top: me.$slide.eq(0)}).css({left: -100});
					repositionEl(me.$slide.eq(5), {top: me.$slide.eq(0), left: me.$slide.eq(4)});
					repositionEl(me.$slide.eq(6), {top: me.$slide.eq(4)}).css({left: 0});
					repositionEl(me.$slide.eq(7), {top: me.$slide.eq(5), left: me.$slide.eq(6)});
					repositionEl(me.$slide.eq(8), {top: me.$slide.eq(3), left: me.$slide.eq(7)});
					repositionEl(me.$slide.eq(9), {top: checkHeight(me.$slide.eq(6), me.$slide.eq(7))}).css({left: 0});
					repositionEl(me.$slide.eq(10), {top: me.$slide.eq(8)});
					repositionEl(me.$slide.eq(11), {top: me.$slide.eq(8)});
					callback();
            	},
            	'medium': function (callback) {
            		me.$slide.removeAttr('style');
            		callback();
            	},
            	'small': function (callback) {
            		me.$slide.removeAttr('style');
            		callback();
            	},
            	'other': function (callback) {
            		me.$slide.css({'position': 'absolute'});
            		
            		repositionEl(me.$slide.eq(0));
            		repositionEl(me.$slide.eq(1), {left: me.$slide.eq(0)}).css({top: 30});
            		repositionEl(me.$slide.eq(2), {left: me.$slide.eq(0), top: me.$slide.eq(1)});
            		repositionEl(me.$slide.eq(3), {top: me.$slide.eq(1), left: me.$slide.eq(2)});
            		repositionEl(me.$slide.eq(4), {top: me.$slide.eq(0)}).css({left: 0});
            		repositionEl(me.$slide.eq(5), {top: me.$slide.eq(3), left: me.$slide.eq(4)});
            		repositionEl(me.$slide.eq(6), {top: me.$slide.eq(3), left: me.$slide.eq(5)});
            		repositionEl(me.$slide.eq(7), {top: me.$slide.eq(3), left: me.$slide.eq(6)});
            		repositionEl(me.$slide.eq(8), {top: me.$slide.eq(5)}).css({left: 0});
            		repositionEl(me.$slide.eq(9), {top: me.$slide.eq(6), left: me.$slide.eq(8)});
            		repositionEl(me.$slide.eq(10), {top: me.$slide.eq(9), left: me.$slide.eq(8)}).css({top: me.$slide.eq(10).position().top+50});
            		repositionEl(me.$slide.eq(11), {top: me.$slide.eq(9), left: me.$slide.eq(10)}).css({top: me.$slide.eq(11).position().top+50});;
            		callback();
            	}
            },
            heightCallback = function () {
	            me.$slide.each(function () {
					var $this = $(this),
						  maxHeight = $this.position().top+$this.outerHeight(true),
						  height = (maxHeight > me.$el.height()? maxHeight: height);
					me.$el.height(height);
				});	
            };
            
			var screenStatus = (cjone.util.getWinWidth() > 1024 && cjone.util.getWinWidth() < 1160 ? 'other': cjone.getScreenStatus());
            resetPosition[screenStatus](heightCallback);
        },

		/**
		 * 포지션 재정렬을 위한 함수
		 * @deprecated 사용하지 않음
		 * @param {Object} options - defaults로 선언된 변수를 재정의
		 * @example
		 		$(selector).triggerHandler('reposition');
		 *  */        
        reposition: function (options) {
        	var me = this;
        },
        
		/**
		 * 이벤트 바인딩
		 * @private
		 *  */
        _bindEvent: function () {
            var me = this;
            
            //윈도우의 크기가 변경되었을 경우 영역의 요소들을 재정렬함
            cjone.$win.on({
				'resize': function (e, data) {
					cjone.$win.setTimeoutCallback(function () {
						me._rePositionCell(e, data);
					}, {delayTime: 0});
				}
			}).triggerHandler('resize');
        }
    });
})(jQuery, window[LIB_NAME]);

$(function () {
	/**
	 * 페이지 랜딩후 실행되는 부분
	 *  */
    var $mainUI = $('body').mainUI();			
    var $repositionSelf = $('[data-control="hotItem"]');
	$repositionSelf.mainHotItem();
});