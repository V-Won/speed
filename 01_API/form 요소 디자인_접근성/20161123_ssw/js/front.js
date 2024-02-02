(function ($, window, undefined){
    "use strict";
	/**
	 * @description 디자인 checkbox
	 * @modify
			@161123 모듈 패턴으로 변경
	*/
	var Ckbox = {
		/** 플러그인명 */
		bindjQuery: 'checkbox',
		/** 기본 옵션값 선언부 */
        defaults: {
        },
        /** selector 선언부 */
		selectors: {
			dataCheckBox: '[data-control="checkbox"]'
		},
		initialize: function(){
			var me = this;

			me._change();
			me._click();
			me._clickTotal();
		},
		_change: function (){
			var me = this,
				$items = me.selectors.dataCheckBox,
				$check = $($items).find('.common-check-wrap');

			$check.find('> input').on('change',function(){
                if ($(this).prop("checked") ==  true)
                {
                    $(this).siblings('label').addClass('on');
                }else{
                    $(this).siblings('label').removeClass('on');
                }
            });
            $check.find('> input').each(function(){
                if ($(this).is(':checked'))
                {
                    $(this).siblings('label').addClass('on');
                }
            });
            $check.focusin(function(){
                me._focusin($(this).find('label'));
            });
            $check.focusout(function(){
            	me._focusout($(this).find('label'));
            });
		},
		_click: function(){
			var me = this,
				$items = me.selectors.dataCheckBox,
				$check = $($items).find('.common-check-wrap.total');

			$check.on('click',function(){
                if ($(this).find('> input').prop("checked") ==  true)
                {
                    $(this).siblings('.common-check-wrap:not(.total)').find('> input').each(function(){
                        $(this).siblings('label').addClass('on');
                        $(this).prop('checked', true);
                    });
                }else{
                    $(this).siblings('.common-check-wrap:not(.total)').find('> input').each(function(){
                        $(this).siblings('label').removeClass('on');
                        $(this).prop('checked', false);
                    });
                }
            });
		},
		_clickTotal: function(){
			var me = this,
				$items = me.selectors.dataCheckBox,
				$check = $($items).find('.common-check-wrap:not(.total)');
				
			$check.find('input').on('change',function(){
                if ($(this).parent().siblings('.common-check-wrap.total').find('input').prop("checked") ==  true) {
                    $(this).parent().siblings('.common-check-wrap:not(.total)').find('input').each(function(){
                        if ($(this).prop("checked") ==  true) {
                            $(this).parent().siblings('.common-check-wrap.total').find('label').removeClass('on');
                            $(this).parent().siblings('.common-check-wrap.total').find('input').prop('checked', false);
                            return false;
                        };
                    });
                };

                var iptNum = $(this).parent().parent().find('.common-check-wrap:not(.total) > input').length;
                var totalCheck = 0;
                for (var i = 0; i < iptNum; i++) {
                    if ($(this).parent().parent().find('.common-check-wrap:not(.total) > input').eq(i).prop("checked") !=  true) {
                        return false;
                    };
                };
                $(this).parent().parent().find('.common-check-wrap.total > label').addClass('on');
                $(this).parent().parent().find('.common-check-wrap.total > input').prop('checked', true);
            });
		},
		_focusin: function(target){
			target.addClass('focus');
		},
		_focusout: function(target){
			target.removeClass('focus');
		}
	};

	window.Ckbox = Ckbox;
}(jQuery, window));

(function ($, window, undefined){
    "use strict";
	/**
	 * @description 디자인 radio
	 * @modify
			@161123 모듈 패턴으로 변경
	*/
	var radio = {
		/** 플러그인명 */
		bindjQuery: 'radio',
		/** 기본 옵션값 선언부 */
        defaults: {
        },
        /** selector 선언부 */
		selectors: {
			dataRadio: '[data-control="radio"]'
		},
		initialize: function(){
			var me = this;

			me._change();
		},
		_change: function (){
			var me = this,
				$items = me.selectors.dataRadio,
				$radio = $($items).find('.common-radio-wrap');

			$radio.find('> input').on('change',function(){
                $(this).parent().parent().find('.common-radio-wrap > input').each(function(){
                    $(this).siblings('label').removeClass('on');
                })
                if ($(this).prop("checked") ==  true)
                {
                    $(this).siblings('label').addClass('on');
                }else{
                    $(this).siblings('label').removeClass('on');
                }
            });
            $radio.find('> input').each(function(){
                if ($(this).is(':checked'))
                {
                    $(this).siblings('label').addClass('on');
                }else{
                    $(this).siblings('label').removeClass('on');
                }
            });
            $radio.focusin(function(){
                me._focusin($(this).find('label'));
            });
            $radio.focusout(function(){
            	me._focusout($(this).find('label'));
            });
		},
		_focusin: function(target){
			target.addClass('focus');
		},
		_focusout: function(target){
			target.removeClass('focus');
		}
	};

	window.radio = radio;
}(jQuery, window));

(function ($, window, undefined){
    "use strict";
	/**
	 * @description 디자인 selectBox
	 * @modify
			@161123 모듈 패턴으로 변경
	*/
	var selectBox = {
		/** 플러그인명 */
		bindjQuery: 'selectBox',
		/** 기본 옵션값 선언부 */
        defaults: {
        },
        /** selector 선언부 */
		selectors: {
			dataRadio: '[data-control="selectBox"]'
		},
		initialize: function(){
			var me = this;

			me._change();
		},
		_change: function (){
			var me = this,
				$items = me.selectors.dataRadio,
				$selectBox = $($items).find('.common-select-wrap');

			$selectBox.find('> select').on('change keyup',function(){
                var select_name = $(this).children("option:selected").text();
                $(this).siblings(".ipt-label").val(select_name);
            });
            $selectBox.find('> select').each(function(){
                var selValue = $(this).find('option:selected').text();

                if (selValue != "")
                {
                    $(this).siblings(".ipt-label").val(selValue);
                }
            });
            $selectBox.focusin(function(){
                me._focusin($(this).find('label'));
            });
            $selectBox.focusout(function(){
                me._focusout($(this).find('label'));
            });
		},
		_focusin: function(target){
			target.addClass('focus');
		},
		_focusout: function(target){
			target.removeClass('focus');
		}
	};

	window.selectBox = selectBox;
}(jQuery, window));

(function ($, window, undefined){
    "use strict";
	/**
	 * @description 디자인 fileBox
	 * @modify
			@161123 모듈 패턴으로 변경
	*/
	var fileBox = {
		/** 플러그인명 */
		bindjQuery: 'fileBox',
		/** 기본 옵션값 선언부 */
        defaults: {
        },
        /** selector 선언부 */
		selectors: {
			dataFileBox: '[data-control="fileBox"]'
		},
		initialize: function(){
			var me = this;

			me._change();
			me._fileDelete();
		},
		_change: function (){
			var me = this,
				$items = me.selectors.dataFileBox,
				$fileBox = $($items).find('.common-file-box .ipt-file');

			$fileBox.on('change',function(){
                var fileTmp = $(this).val(),
                	fileSize = Math.round((this.files[0].size/1024)); //KB

                if (fileSize < 2048) { // 2MB = 2048KB
                    fileTmp = fileTmp + " (" + fileSize + "KB)";
                    fileTmp = fileTmp.replace("C:\\fakepath\\", "");
                    $(this).siblings('.file-name').text(fileTmp);
                    $(this).siblings('.btn-file.del').show();
                }else{
                    fileTmp = '';
                    fileSize = '';
                    alert('파일용량이 2048KB를 넘었습니다.');
                };

            });
            $fileBox.focusin(function(){
                me._focusin($(this).siblings('.btn-file'));
            });
            $fileBox.focusout(function(){
                me._focusout($(this).siblings('.btn-file'));
            });
            $fileBox.each(function(){
                if ($(this).val() != '')
                {   
                    $(this).siblings('.btn-file.del').show();
                    var fileTmp = $(this).val();
                    // var fileSize = (Math.round((this.files[0].size/1024/1024) * 100)) / 100; //MB
                    var fileSize = Math.round((this.files[0].size/1024/1024)); //KB
                    if (fileSize < 2048) { // 2MB = 2048KB
                        fileTmp = fileTmp + " (" + fileSize + "KB)";
                        fileTmp = fileTmp.replace("C:\\fakepath\\", "");
                        $(this).siblings('.file-name').text(fileTmp);
                    }else{
                        fileTmp = '';
                        fileSize = '';
                        alert('파일용량이 2048KB를 넘었습니다.');
                    };

                }
            });
		},
		_fileDelete: function(){
			var me = this,
				$items = me.selectors.dataFileBox,
				$fileBox = $($items).find('.common-file-box .ipt-file');

			$fileBox.siblings('.btn-file.del').on('click',function(){
                $(this).siblings('.ipt-file').val('');
                $(this).siblings('.file-name').text('파일명 (용량)');
                $(this).hide();
            });
            $('#btnFileDel').on('click',function(){
                $(this).parent().siblings('.common-file-box').find('.ipt-file').val('');
                $(this).parent().siblings('.common-file-box').find('.file-name').text('파일명 (용량)');
            });
		},
		_focusin: function(target){
			target.addClass('focus');
		},
		_focusout: function(target){
			target.removeClass('focus');
		}
	};

	window.fileBox = fileBox;
}(jQuery, window));