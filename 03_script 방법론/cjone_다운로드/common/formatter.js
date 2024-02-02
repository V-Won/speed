/**
 * Benchmark
 * github: https://github.com/firstopinion/formatter.js
 * www.cambiaresearch.com/articles/15/javascript-key-codes
 * License: The MIT License (MIT) Copyright (c) 2013 First Opinion
 */
/**
 * @description 
  		160831: data-format="email" 이고 @값이 두개가 들어가는 경우 추후 적용
 *  */
(function ($, core) {
    "use strict";

    var inputSel = {
        // 캐럿 위치 반환
        get: function(el) {
            if(core.is(el.selectionStart, 'number')) {
                return {
                    begin: el.selectionStart,
                    end: el.selectionEnd
                };
            }

            var range = document.selection.createRange();
            if(range && range.parentElement() === el) {
                var inputRange = el.createTextRange(), endRange = el.createTextRange(), length = el.value.length;
                inputRange.moveToBookmark(range.getBookmark());
                endRange.collapse(false);

                if(inputRange.compareEndPoints('StartToEnd', endRange) > -1) {
                    return {
                        begin: length,
                        end: length
                    };
                }
                return {
                    begin: -inputRange.moveStart('character', -length),
                    end: -inputRange.moveEnd('character', -length)
                };
            }
            return {
                begin: 0,
                end: 0
            };
        },
        
        // 캐럿 위치 설정
        set: function(el, pos) {
            if(!core.is(pos, 'object')) {
                pos = {
                    begin: pos,
                    end: pos
                };
            }

            if(el.setSelectionRange) {
                //el.focus();
                el.setSelectionRange(pos.begin, pos.end);
            } else if(el.createTextRange) {
                var range = el.createTextRange();
                range.collapse(true);
                range.moveEnd('character', pos.end);
                range.moveStart('character', pos.begin);
                range.select();
            }
        }
    };

	/**
	 * 정규식 설정및 허용할 키코드에 대한 설정부분
	 *  */
	var utils = {
		numRegex: /[^0-9]/g,
		engRegex: /[^a-zA-Z\s]/g,
		alphaRegex: /[^a-zA-Z]/g,
		alnumRegex: /[^a-zA-Z0-9]/g,
        emailRegex: /[^-._a-zA-Z0-9]/g,
		engnumRegex: /[^a-zA-Z0-9\s]/g, 

		isPressedMetaKey: function (e) {
			return e.ctrlKey || e.shiftKey || e.altKey;
		},
		numKey: function (e) {
			var kc = e.keyCode;
			return (e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105);
		},
		engKey: function (e) {
			var kc = e.keyCode;
			return (kc >= 65 && kc <=90) || (kc >= 97 && kc <=122) || kc === 32; // 32: space bar
		},
		alphaKey: function (e) {
			var kc = e.keyCode;
			return (kc >= 65 && kc <=90) || (kc >= 97 && kc <=122);
		},
        alnumKey: function (e) {
			var kc = e.keyCode;
			return (kc >= 65 && kc <= 90) || (kc >= 97 && kc <= 122) || (kc >= 48 && kc <= 57);
		},
		emailKey: function (e) {
			var kc = e.keyCode;
			return (kc >= 65 && kc <= 90) || (kc >= 96 && kc <= 122) || (kc >= 48 && kc <= 57) || (kc==189 || kc==190 || kc == 173);
		},
		engnumKey: function (e) {
			var kc = e.keyCode;
			return (kc >= 65 && kc <= 90) || (kc >= 97 && kc <= 122) || (kc >= 48 && kc <= 57) || kc === 32; // 32: space bar
		},
		isInvalidKey: function (e, type, ignoreKeys) {
			return !utils.isPressedMetaKey(e) && !utils[type+'Key'](e) && !core.array.include(ignoreKeys, e.keyCode);
		},
		cleanChars: function (type, el, focusin) {
			if (!supportPlaceholder && el.value === el.getAttribute('placeholder')) { return; }
			setTimeout(function () {			//ie input영역 선택후 select 선택시 가로폭 길어지는 부분 보완
				var caret = inputSel.get(el);
				el.value = el.value.replace(utils[type+'Regex'], '');
				if (focusin) {
					inputSel.set(el, Math.min(caret.begin, el.value.length));
				}
			}, 0);
		},

        forceKeyup: function (el) {
            // 파이어폭스에서 한글을 입력할 때 keyup이벤트가 발생하지 않는 버그가 있어서
            // 타이머로 value값이 변경된걸 체크해서 강제로 keyup 이벤트를 발생시켜 주어야 한다.
            var me = this,
                $el = $(el),
                prevValue, nowValue,
                win = window,
                doc = document,

            	// keyup 이벤트 발생함수: 크로스브라우징 처리
                fireEvent = (function(){
                    if (doc.createEvent) {
                        // no ie
                        return function(oldValue){
                            var e;
                            if (win.KeyEvent) {
                                e = doc.createEvent('KeyEvents');
                                e.initKeyEvent('keyup', true, true, win, false, false, false, false, 65, 0);
                            } else {
                                e = doc.createEvent('UIEvents');
                                e.initUIEvent('keyup', true, true, win, 1);
                                e.keyCode = 65;
                            }
                            el.dispatchEvent(e);
                        };
                    } else {
                        // ie: :(
                        return function(oldValue) {
                            var e = doc.createEventObject();
                            e.keyCode = 65;
                            el.fireEvent('onkeyup', e);
                        };
                    }
                })();

            var timer = null;
            $el.on('focusin', function(){
                if (timer){ return; }
                timer = setInterval(function() {
                    nowValue = el.value;
                    if (prevValue !== nowValue) {
	                    prevValue = nowValue;
	                    fireEvent();
                    }
                }, 60);
            }).on('focuout', function(){
                if (timer){
                    clearInterval(timer);
                    timer = null;
                }
            });
        }
	};
	
	/**
	 * 한글 영문 전용 입력퐄
	 *  */
	var EngKorInput = core.ui.View.extend({
        name: 'engKorInput',
        initialize: function (el, options) {
            var me = this;

            if (me.supr(el, options) === false) { return; }

            me.$el = $(el);
            me._bindEvents();
        },
        _bindEvents: function () {
            var me = this,
                caret,
                regNotKor = /[^a-zA-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힝 ]+/;

            me.$el.on('keyup paste change', function (e) {
                var val = me.$el.val();

                if (regNotKor.test(val)) {
                    val = val.replace(regNotKor, '');
                    if (caret.start > 0){ caret.start -= 1; }
                    me.$el.val(val);
                    if (me.$el.is(':focus')){
                        core.dom.setCaretPos(me.$el[0], caret);
                    }
                }
            }).on('keydown  focusin', function(e){
                caret = core.dom.getCaretPos(me.$el[0]);
            });
        },
        release: function () {
            var me = this;
            clearInterval(me.timer);
            me.supr();
        }
    });

    /**
     * 한글 전용 입력폼
     */
    var KorInput = core.ui.View.extend({
        name: 'korInput',
        initialize: function (el, options) {
            var me = this;

            if (me.supr(el, options) === false) { return; }

            me.$el = $(el);
            me._bindEvents();
        },
        _bindEvents: function () {
            var me = this,
                caret,
                regNotKor = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힝 ]+/;

            me.$el.on('keyup paste change', function (e) {
                var val = me.$el.val();

                if (regNotKor.test(val)) {
                    val = val.replace(regNotKor, '');
                    if (caret.start > 0){ caret.start -= 1; }
                    me.$el.val(val);
                    if (me.$el.is(':focus')){
                        core.dom.setCaretPos(me.$el[0], caret);
                    }
                }
            }).on('keydown  focusin', function(e){
                caret = core.dom.getCaretPos(me.$el[0]);
            });
        },
        release: function () {
            var me = this;
            clearInterval(me.timer);
            me.supr();
        }
    });

    /*
     * 영숫자 전용 입력폼
     */
    var AlnumInput = core.ui.View.extend({
        name: 'alnumInput',
        initialize: function (el, options) {
            var me = this;
            if (me.supr(el, options) === false) { return; }

	        if (core.browser.isGecko) {
		        utils.forceKeyup(me.el);
	        }

            var old, format = me.options.format;
            me.$el.on('keydown focusin keyup focusout paste change', function(e) {
                var el = this, change;
                switch (e.type) {
                    case 'keydown':
                    	//shift키 중복입력시 발생하는 오류건에 대한 보안 처리 @160818
                    	/*var byPassKeys = [8, 9, 16, 17, 18, 35, 36, 37, 38, 39, 40, 46, 91, 116];
                        if(utils.isInvalidKey(e, format, [].concat(FormatInput.byPassKeys, 16)) || (e.shiftKey == true && !core.array.include(byPassKeys, e.keyCode))) {*/
                        if(utils.isInvalidKey(e, format, [].concat(FormatInput.byPassKeys, 16))) {
                            e.preventDefault();
                        }
                        break;
                    case 'focusin':
                        //old = this.value;
                        break;
                    case 'keyup':
                    	//if (old != el.value || e.shiftKey == true) {			//data-format="email" 이고 @값이 두개가 들어가는 경우 추후 적용
                        if (old != el.value) {
                            setTimeout(function () {
                                utils.cleanChars(format, el, false);
                            });
                        }
                        old = el.value;
                        break;
                    case 'focusout':
                    case 'paste':
                    case 'change':
                        //utils.cleanChars(format, el, e.type !== 'focusout');//@160607
                        break;
                }
            });
        }
    });
    

    // placeholder 지원여부
    var supportPlaceholder = ('placeholder' in document.createElement('input'));

    /**
     * 형식 입력폼 모듈
     * @module
     * @name cjone.ui.FormatInput
     * @extends cjone.ui.View
     * @example
     		params {string} data-format [num: 숫자만 | eng: 영문만 | kor: 한글만 | alnum: 영, 숫자]
     * @description
	     	//{{9999}}-{{9999}}-{{9999}}
		    // comma
		    // tel
		    // mobile
		    // email
		    // alnum
     */
    var FormatInput = core.ui('FormatInput', /** @lends cjone.ui.Formatter */{
        $statics: {
            // 허용할 기능키
            byPassKeys: [8, 9, 16, 17, 18, 35, 36, 37, 38, 39, 40, 46, 91, 116],
            // 각 코드에 대한 정규식
            translation: {
                '0': {pattern: /\d/},
                '9': {pattern: /\d/, optional: true},
                '#': {pattern: /\d/, recursive: true},
                'A': {pattern: /[a-zA-Z0-9]/},
                'a': {pattern: /[a-zA-Z]/},
                'o': {pattern: /[0-1]/},    // 월 앞자리
	            'm': {pattern: /[0-2]/},    // 월 뒷자리
                'M': {pattern: /[0-3]/},
	            'n': {pattern: /[1-9]/},
	            'e': {pattern: /[0-8]/}, // 2월 28
	            'E': {pattern: /[0-9]/}, // 2월 29
	            'Z': {pattern: /0/},
	            'Y': {pattern: /[1-2]/},
	            'ek': {pattern:  /[a-zA-Z]/}
            },
            // 마스킹 타입
            masks: {
                // 현금
                comma: {
	                format: '000,000,000,000,000,000,000,000,000',
	                valid: function (value, field, options) {
		                value = value.replace(/\D/g, '');

		                var len = value.length;
		                if (len <= 3) {
			                return value;
		                }
		                var maxlength = parseInt(field.getAttribute('maxlength') || 13, 10),
			                mod = maxlength - Math.floor((len - 1) / 3);

						return value.substr(0, mod);
	                },
	                reverse: true
                },
                // 전화번호
                tel: {
                    format: function(val, field, options) {
                        return val.replace(/\D/g, '').length < 8 ? '000-0000' : '0000-0000';
                    }
                },
                // 핸드폰 번호
                mobile: {
                    format: function(val, field, options) {
                        var maxlength = parseInt(field.getAttribute('maxlength') || 9, 10);

	                    val = val.replace(/\D/g, '');
	                    if (maxlength > 9) {
		                    return val.length < 11 ? '000-000-0000' : '000-0000-0000';
	                    } else {
		                    return val.length < 8 ? '000-0000' : '0000-0000';
	                    }
                    }
                },
                // 숫자
                num: {format: '0000000000000000000'},
                // 카드
                card: {format: '0000-0000-0000-0000'},
                // 아멕스카드
                amexcard: {format: '0000-000000-00000'},
	            // 카드 자동인식
	            allcard: {
		            format: function (val, field, options) {
			            if (val.substr(0, 4) === '3791') {
				            // 아멕스 카드
				            return '0000-000000-00000';
			            }
			            return '0000-0000-0000-0000';
		            }
	            },
                // 운전면허번호
                driverno: {format: '00-000000-00'},
                // 사업자번호
                bizno: {format:'000-00-00000'},
                // 법인번호
                corpno: {format:'000000-0000000'},
                // 날짜
                date: {
	                format: function (val, field, options) { //'0000.M0.m0'
		                val = val.replace(/[^0-9]/g, '').substr(0, 8);
		                var len = val.length, ch, y, m, d;
		                switch(len) {
			                case 5:
				                return 'Y000.o';
			                case 6:
				                ch = val.substr(4, 1);
				                if (ch === '1') {
					                return 'Y000.om';
				                } else if (ch === '0') {
					                return 'Y000.on';
				                }
			                case 7:
				                if (val.substr(4, 2) === '02') {
					                return 'Y000.o0.m';
				                }
				                return 'Y000.oE.M';
			                case 8:
				                y = parseInt(val.substr(0, 4), 10);
				                m = parseInt(val.substr(4, 2), 10);
				                d = parseInt(val.substr(6, 2), 10);

				                if (m === 2) {
					                if (core.date.isLeapYear(y, m)) {
						                return 'Y000.Zm.0E';
					                } else {
						                return 'Y000.oE.0e';
					                }
				                } else if (d >= 30) {
					                if (m === 1 || m === 3 || m === 5 || m === 7 || m === 8 || m === 10 || m === 12) {
						                return 'Y000.oE.0o';
					                } else {
						                return 'Y000.oE.0Z';
					                }
				                } else if (d === 0) {
					                return 'Y000.oE.Zn';
				                }
		                }
		                return 'Y000.oE.ME';
	                }
                },
	            // 영문
	            eng: {format: 'a'}
            }
        },
        bindjQuery: 'formatter',
        /**	기본 옵션값 선언부	*/
        defaults: {
            format: 'comma', 		/** @member {String} format - 기본 포맷 */ 
            watch: false,    			/** @member {Booleand} watch - 수정을 감시할건가 */ 
            watchInterval: 300 	/** @member {Double} watchInterval - 감시 인터벌 */ 
        },
        /**
         * 생성자
         * @param el
         * @param options
         * @returns {boolean}
         */
		/**
         * 생성자
         * @constructors
         * @param {String|Element|jQuery} el
         * @param {Object} options
         * @param {Boolean}  options.format - 기본 포맷
         * @param {Boolean}  options.watch - 수정을 감시할건가
         * @param {Boolean}  options.watchInterval - 감시 인터벌
         * @returns {Boolean}
         */
        initialize: function(el, options) {
            var me = this;

            if(me.supr(el, options) === false) { return false; }

            // 자동완성 끜
            me.$el.attr('autocomplete', 'off');

	        // 원래 이게 여기 있으면 안되는데, 퍼블리싱에서 파일을 전부 다 바꿔야 된대서..걍 스크립트단에서 해줌
            if (me.options.format === 'allcard' || me.options.format === 'card') {
	            me.$el.attr('maxlength', 19);
            }

	        // IME mode 설정
	        me._setIMEMode();

            // 숫자 와 같이 단순한 포맷은 걍 키만 막고 빠져나간다
            if(me._isSimpleFormat() === true) {
	            me.clean = function () { return me.$el.val() === me.txtPlaceholder ? '' : me.$el.val(); };
	            me.update = function (){ me.inputModule.update(); };
                return;
            }

            me.oldValue = me.$el.val(); // 원래 값
            me.byPassKeys = FormatInput.byPassKeys; // alias
            me.translation = core.extend({}, FormatInput.translation, me.options.translation);  // alias
            me.invalid = [];

            if(!supportPlaceholder) {
                // placeholder를 지원하지 않는 브라우저면 placeholder 문구를 보관하고 있는다.
                me.notSupportPlaceholder = true;
                me.txtPlaceholder = me.$el.attr('placeholder');
            }

	        if (core.browser.isGecko) {
		        //utils.forceKeyup(me.el);
	        }

            me._reloadMask();
            if(me.$el.is(':focus')) {
	            var caret = inputSel.get(me.el).begin; // 캐럿 위치를 보관
	            me.update();
                inputSel.set(me.el, caret + me._getMCharsBeforeCount(caret, true));
            } else {
	            me.update();
                // 값이 변경됐는지 감시
                if (me.options.watch) {
                    me._watchStart();
                }
            }

            me.regexMask = me._getRegexMask();    // 마스킹에 대한 전체 정규식을 가져온다

	        // 이벤트 바인딩
	        me._bindEvents();
        },

	    /**
	     * 이벤트 바인딩
	     * @private
	     */
	    _bindEvents: function() {
		    var me = this;

		    me.$el
			    .on('keyup', function(e) {
				    me._reloadMask();
				    me._process(e);
			    })
			    .on('paste drop', function() {
				    setTimeout(function() {
					    me.$el.keydown().keyup();
				    });
			    })
			    .on('keydown blur', function() {
				    me.oldValue = me.$el.val();
			    })
			    .on('change', function () {
				    me.$el.data('changed', true);
			    })
			    .on('blur', function (){
				    if (me.oldValue !== me.$el.val() && !me.$el.data('changed')) {
					    me.$el.triggerHandler('change');
				    }
				    me.oldValue = me.$el.val();
				    me.$el.data('changed', false);
			    })
			    .on('focusin', function() {
				    // 포커싱될 때 셀렉트시킬 것인가..
				    if(me.options.selectOnFocus === true) {
					    $(e.target).select();
				    }
				    me._watchStop();
			    })
			    .on('focusout', function() {
				    me._watchStart();

				    // 포커스가 나갈 때 안맞는 값을 지울것인가
				    if(me.options.clearIfNotMatch && !me.regexMask.test(me.$el.val())) {
					    me.$el.val('');
				    }
                    me.$el.triggerHandler('blur:out', {data: me});
			    });

		    me.$el.on('optionchange', function (e, data) {
			    if(data.name === 'format') {
				    me.$el.attr('data-format', data.value);
				    me.update();
			    }
		    });

		    // comma 형식일 땐 ,가 제거된 상태로 넘어가게
		    me.options.format === 'comma' && $(me.el.form).on('submit', function(e) {
			    me.remove();
			    me.oldValue = '';
		    });
	    },

		/**
		 * IME 모드 셋업
		 * @private
		 *  */
	    _setIMEMode: function () {
		    var me = this;

		    switch(me.$el.data('format')) {
			    case 'eng':
			    case 'num':
			    case 'alnum':
			    case 'tel':
			    case 'mobile':
			    case 'allcard':
			    case 'card':
			    case 'amexcard':
			    case 'comma':
			    case 'driverno':
			    case 'corpno':
			    case 'bizno':
			    case 'date':
                case 'email':
				    me.$el.css('ime-mode', 'disabled');
				    break;
			    case 'kor':
				    me.$el.css('ime-mode', 'active');
				    break;
		    }
	    },

	    /**
	     * 숫자, 영문자 만 입력하는거면 마스킹 처리는 하지 않고 키보드만 막는다.
	     * @returns {boolean}
	     * @private
	     */
	    _isSimpleFormat: function(){
		    var me = this,
			    format = me.options.format;

		    if(format === 'eng' || format === 'alnum' || format === 'num' || format === 'email') {
			    me.inputModule = new AlnumInput(me.$el[0], {format: format});
			    if (core.browser.isMobile && format === 'num' && me.el.type !== 'password') {
				    me.$el.attr('type', 'tel');
			    }
			    return true;  // 마스킹은 처리안하도록 true 반환
		    } else if(core.array.include(['allcard', 'card', 'amexcard',
				    'tel', 'mobile', 'driverno', 'bizno', 'corpno', 'comma', 'date'], format)) {
			    if (core.browser.isMobile && me.el.type !== 'password') {
				    me.$el.attr('type', 'tel');
			    }
			    // 숫자
			    me.$el.on('keydown', function(e) {
				    if (utils.isInvalidKey(e, 'num', FormatInput.byPassKeys)) {
					    e.preventDefault();
				    }
			    });
		    } else if (format === 'kor') {
			    me.inputModule = new KorInput(me.$el[0]);
			    return true;
		    } else if (format === 'engkor') {
		    	me.inputModule = new EngKorInput(me.$el[0]);
		    	return true;
		    }
	    },

        /**
         * 값이 변경됐는지 감시 시작
         * @private
         */
        _watchStart: function(){
            var me = this;
            me._watchStop();

            if(!me.options.watch || me.$el.prop('readonly') || me.$el.prop('disabled')) { return; }

            var totalTime = 0, dur = me.options.watchInterval;
            me.watchTimer = setInterval(function() {
                // 40초에 한번씩 dom에서 제거 됐건지 체크해서 타이머를 멈춘다.
                if (totalTime > 40000){
                    totalTime = 0;
                    if (!$.contains(document, me.$el[0])) {
                        clearInterval(me.watchTimer);
                        me.watchTimer = null;
	                    return;
                    }
                } else {
                    totalTime += dur;
                }
	            if (!me.$el){ clearInterval(me.watchTimer); me.watchTimer = null; return; }
                if (me.$el[0].disabled || 0 <= me.$el[0].className.indexOf('disabled')) { return; }

                var val = me.$el.val();
                if(val && me.oldValue != val){
                    me.update();
                }
            }, dur);
        },

        /**
         * 값 변경 감시 중지
         * @private
         */
        _watchStop: function() {
            var me = this;
            clearInterval(me.watchTimer);
            me.watchTimer = null;
        },

        /**
         * 마스킹에 대한 정규식 반환
         * @returns {RegExp}
         * @private
         */
        _getRegexMask: function() {
            var me = this,
                maskChunks = [],
                translation, pattern, optional, recursive, oRecursive, r, ch;

            for(var i = 0, len = me.mask.length; i < len; i++) {
                ch = me.mask.charAt(i);
                if(translation = me.translation[ch]){
                    pattern = translation.pattern.toString().replace(/.{1}$|^.{1}/g, '');
                    optional = translation.optional;
                    if(recursive = translation.recursive){
                        maskChunks.push(ch);
                        oRecursive = {digit: ch, pattern: pattern};
                    } else {
                        maskChunks.push(!optional ? pattern : (pattern + '?'));
                    }
                } else {
                    maskChunks.push(ch.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'));
                }
            }

            r = maskChunks.join('');
            // 기준을 끝으로 했을 때
            if(oRecursive) {
                r = r.replace(new RegExp('(' + oRecursive.digit + '(.*' + oRecursive.digit + ')?)'), '($1)?')
                    .replace(new RegExp(oRecursive.digit, 'g'), oRecursive.pattern);
            }

            return new RegExp(r);
        },
        /**
         * index위치의 마스킹처리된 문자수
         * @param index
         * @param onCleanVal
         * @returns {number}
         * @private
         */
        _getMCharsBeforeCount: function(index, onCleanVal) {
            var me = this, mask = me.mask;
            for (var count = 0, i = 0, maskL = mask.length; i < maskL && i < index; i++) {
                if (!me.translation[mask.charAt(i)]) {
                    index = onCleanVal ? index + 1 : index;
                    count++;
                }
            }
            return count;
        },
        /**
         * 캐럿 위치
         * @param originalCaretPos
         * @param oldLength
         * @param newLength
         * @param maskDif
         * @returns {*}
         * @private
         */
        _caretPos: function (originalCaretPos, oldLength, newLength, maskDif) {
            var me = this,
                mask = me.mask,
                translation = me.translation[mask.charAt(Math.min(originalCaretPos - 1, mask.length - 1))];

            return !translation ? me._caretPos(originalCaretPos + 1, oldLength, newLength, maskDif)
                : Math.min(originalCaretPos + newLength - oldLength - maskDif, newLength);
        },
        /**
         * 마스킹처리
         * @param e
         * @returns {*}
         * @private
         */
        _process: function(e) {
            var me = this,
                keyCode = e.keyCode;
	        // TODO
            if (keyCode === 17 || (keyCode === 65 && e.ctrlKey)) { return; }

            me.invalid = [];
            if ($.inArray(keyCode, me.byPassKeys) === -1 || keyCode === 46 || keyCode === 8) {
                var caretPos = inputSel.get(me.el).begin,
                    currVal = me.maskOption.valid ? me.maskOption.valid(me.$el.val(), me.$el[0]) : me.$el.val(),
                    currValL = currVal.length,
                    changeCaret = caretPos < currValL,
                    newVal = me._getMasked(currVal),
                    newValL = newVal.length,
                    isFocusin = me.$el.is(':focus'),
                    maskDif;

                me.el.value = newVal;
                if (isFocusin && changeCaret && !(keyCode === 65 && e.ctrlKey)) {
                    if (!(keyCode === 8 || keyCode === 46)) {
                        maskDif = me._getMCharsBeforeCount(newValL - 1) - me._getMCharsBeforeCount(currValL - 1);
                        //TODO caretPos = me._caretPos(caretPos, currValL, newValL, maskDif);
                        if (newValL != currValL) {
                            caretPos += 1;
                        }
                    }
                    inputSel.set(me.el, caretPos);
                }
                return me._callbacks(e);
            }
        },

	    /**
	     * 마스킹 옵션이 변경됐을 수도 있기 때문에 다시 정규화 한다.
	     * @private
	     */
	    _reloadMask: function() {
		    var me = this,
			    m, mask;

		    me.$el.data('format', me.options.format = me.$el.data('format'));
		    if(m = FormatInput.masks[me.options.format]) {
			    me.maskOption = m;
			    if(core.is(m.format, 'function')) {
				    me.mask = m.format.call(me, me.$el.val(), me.$el[0], me.options);
			    } else {
				    me.mask = m.format;
			    }
			    me.options.reverse = !!m.reverse;
		    } else {
			    me.mask = core.is(me.options.format, 'function') ? me.options.format.call(me) : me.options.format;
		    }
	    },

        /**
         * 마스킹처리 코어부분
         * @param skipMaskChars
         * @returns {string}
         * @private
         */
        _getMasked: function(value, skipMaskChars) {
            this._reloadMask();

	        if (!value) { return ''; }

            var me = this,
                mask = me.mask,
                buf = [],
                m = 0, maskLen = mask.length,
                v = 0, valLen = value.length,
                offset = 1, addMethod = 'push',
                resetPos = -1,
                lastMaskChar,
                check;

            if (me.options.reverse) {
                addMethod = 'unshift';
                offset = -1;
                lastMaskChar = 0;
                m = maskLen - 1;
                v = valLen - 1;
                check = function () {
                    return m > -1 && v > -1;
                };
            } else {
                lastMaskChar = maskLen - 1;
                check = function () {
                    return m < maskLen && v < valLen;
                };
            }

            while (check()) {
                var maskDigit = mask.charAt(m),
                    valDigit = value.charAt(v),
                    translation = me.translation[maskDigit];

                if (translation) {
                    if (valDigit.match(translation.pattern)) {
                        buf[addMethod](valDigit);
                        if (translation.recursive) {
                            if (resetPos === -1) {
                                resetPos = m;
                            } else if (m === lastMaskChar) {
                                m = resetPos - offset;
                            }

                            if (lastMaskChar === resetPos) {
                                m -= offset;
                            }
                        }
                        m += offset;
                    } else if (translation.optional) {
                        m += offset;
                        v -= offset;
                    } else if (translation.fallback) {
                        buf[addMethod](translation.fallback);
                        m += offset;
                        v -= offset;
                    } else {
                        me.invalid.push({p: v, v: valDigit, e: translation.pattern});
                    }
                    v += offset;
                } else {
                    if (!skipMaskChars) {
                        buf[addMethod](maskDigit);
                    }

                    if (valDigit === maskDigit) {
                        v += offset;
                    }

                    m += offset;
                }
            }

            var lastMaskCharDigit = mask.charAt(lastMaskChar);
            if (maskLen === valLen + 1 && !me.translation[lastMaskCharDigit]) {
                buf.push(lastMaskCharDigit);
            }

            return buf.join('');
        },

	    /**
         * 콜백함수 바인딩
         * @param e
         * @private
         */
        _callbacks: function (e) {
            var me = this,
                mask = me.mask,
                val = me.$el.val(),
                changed = val !== me.oldValue,
                defaultArgs = [val, e, me.el, me.options],
                callback = function(name, criteria, args) {
                    if (typeof me.options[name] === 'function' && criteria) {
                        me.options[name].apply(this, args);
                    }
                };

            callback('onChange', changed === true, defaultArgs);
            callback('onKeyPress', changed === true, defaultArgs);
            callback('onComplete', val.length === mask.length, defaultArgs);
            callback('onInvalid', me.invalid.length > 0, [val, e, me.el, me.invalid, me.options]);
        },
        /**
         * 지우기
         */
        remove: function() {
            var me = this,
                caret = inputSel.get(me.el).begin;
	        me._watchStop();
            me.$el.off();
            me.$el.val(me.clean());
            if(me.$el.is(':focus')) {
                inputSel.set(me.el, caret - me._getMCharsBeforeCount(caret));
            }
        },
        /**
         * 마스킹 제거
         * @returns {*|string}
         */
        clean: function() {
            return this._getMasked(this.$el.val(), true);
        },

	    /**
	     * 마스킹처리된 값을 인풋에 넣어준다
	     */
	    update: function() {
		    var me = this,
			    val = me.$el.val();


		    if (val) {
			    me.$el.val(me._getMasked(val));
		    }
	    },

	    release: function (){
		    clearInterval(this.watchTimer);
		    this.watchTimer = null;

            if (me.inputModule) {
                try { this.inputModule.release(); this.inputModule = null; } catch(e){}
            }
		    this.supr();
	    }
    });

    if (typeof define === "function" && define.amd) {
        define([], function() {
            return FormatInput;
        });
    }

})(jQuery, window[LIB_NAME]);