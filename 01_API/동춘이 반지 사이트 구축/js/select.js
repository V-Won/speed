var cb_i = 0;

// Plug-ins
(function($){
	var browser = (function() {
	  var s = navigator.userAgent.toLowerCase();
	  var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
	              /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
	              /(msie) ([\w.]+)/.exec(s) ||               
	              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
	             [];
	  return { name: match[1] || "", version: match[2] || "0" };
	}());

	/* ***************** fe_select ARIA MODI********************** */
	// fe_select Methods
	var fe_select_methods = {
		init : function(options) {
			if ( browser.msie ) {
				if ( browser.version < 7 ) {
					return false;
				}
			}
			var options = $.extend({}, $.fn.fe_select.defaults, options);
			return this.each(function(i) {
				if ( $(this).prev(".fe_selectWrap").length ) {
					$(this).prev(".fe_selectWrap").remove();
				}
				var $original = $(this);
				var fixedWidth = $original.hasClass('fixedWidth');
				var selectAnimationSpeed = 150;
				var selectDisabled = $original.attr("disabled") ? true : false;
				var selectDisableClass = options.disableClass;
				var $select, $selectTrigger, $selectList, $selectListWrap, $selectOption, selectValue, selectIndex;
				$original.find("option").each(function(i,o){	//option top blank remove
					if($.trim($(o).text()) == ""){
						$(o).remove();
					}
				});
				var optionLength = $original.find("option").length;
				var listHTML = "";
				var selectHTML;
				var selectListHeight = 0;
				var marginRight = 5;
				var ori_labelledby = "";
				if ($original.attr("aria-labelledby")!=undefined){
					ori_labelledby = $original.attr("aria-labelledby");
				}
				selectIndex	 = $original.prop("selectedIndex");

				selectValue = $original.find("option:selected").text();
				selectWidth = $original.outerWidth();	// Temp : must be css fixedWidth width modified
				$select = $("<div />", { "class" : "fe_selectWrap" + ($original.hasClass('fe_selectHidden') ? " fe_selectHidden" : "")}).insertBefore($original);
				cb_i++;
				selectHTML = '<p class="fe_select_triggerWrap">'
										+'<input id="cb'+cb_i+'-edit" class="cb_edit"'
										+' type="text" tabindex="0"'
										+' role="combobox"'
										+' aria-autocomplete="none"'
										+' aria-owns="cb'+cb_i+'-list"'
										+' aria-readonly="true"'
										//+' aria-activedescendant="cb'+cb_i+'-opt'+selectIndex+'"'
										+' value="'+selectValue+'"'
										+' readonly /></p>\n'
										+'<div class="fe_selectListWrap">\n'
										+'<ul class="fe_selectList" id="cb'+cb_i+'-list" class="cb_list" tabindex="-1" aria-expanded="false">\n'
										+'</ul>\n'
										+'</div>\n';
				$select.html(selectHTML);
				$selectTrigger = $select.find("p.fe_select_triggerWrap input.cb_edit");
				$selectList = $select.find("ul.fe_selectList");
				$selectListWrap = $select.find("div.fe_selectListWrap");
				$selectListBottom = '<div class="fe_selectListBottom"><span class="fe_selectInside"></span></div>';
				if (ori_labelledby != ""){
					$selectTrigger.attr("aria-labelledby",ori_labelledby);
				}else if (typeof($select.prev())!="undefined" && typeof($select.prev().get(0))!="undefined"){
					if($select.prev().get(0).tagName.toLowerCase()=="label"){	//select 이전에 label이 있을경우 aria-labelledby setting
						$select.prev().attr("id","cb"+cb_i+"-label");
						$selectTrigger.attr("aria-labelledby","cb"+cb_i+"-label");
					}
				}

				if ( browser.msie ) {
					$selectTrigger.css("padding-top","2px");
					if ( browser.version <= 7 ) {
						$selectTrigger.css("margin-top","-1px");
					}
				}
				// list
				listHTML = getOptionHTML($original, cb_i, false);
				$selectList.html(listHTML);
				$selectOption = $selectList.find("li.cb_option");
				//$selectTrigger.text(selectValue);
				$selectListWrap.hide();
				// css
				if ( selectDisabled ) $select.addClass(selectDisableClass);
				if ( !fixedWidth && selectWidth > 200 ) selectWidth = 200;
				$selectTrigger.parent().css({
					"width" : selectWidth + marginRight + 10  + "px"
				});
				$selectTrigger.width((Number(selectWidth)-18)+"px");
				if ( browser.webkit ) {
					$selectTrigger.parent().css({
						"width" : selectWidth	+ marginRight + 10 + "px"
					});
				}
				$selectListWrap.css({
					"width" : $selectTrigger.parent().width() + 11 + "px"
				});
				if ( $selectOption.length > 7 ) {
					$selectList.css({
						"height" : "161px",
						"overflow-y" : "auto"
					});
				}
				$selectOption.eq(selectIndex).addClass("activator");
				$original.hide();
				if ( !selectDisabled ) {
					$selectTrigger.unbind("click.fe_select").bind("click.fe_select",function() {
						if ( $selectListWrap.is(":visible") ) {
							comboClose();
						} else {
							comboOpen();
						}
						return false;
					});
				}
				else {
					$selectTrigger.unbind("click..fe_select").bind("click..fe_select",function() { return false; });
				}
				$selectOption.each(function(i) {
					$(this).unbind("mouseenter.fe_select mouseleave.fe_select click.fe_select").bind({
						"mouseenter.fe_select" : function() {
							if ( ($selectOption.length - 1) == i ) {
								$(this).parent().next().addClass("bottomHover");
							}
						},
						"mouseleave.fe_select" : function() {
							if ( ($selectOption.length - 1) == i ) {
								$(this).parent().next().removeClass("bottomHover");
							}
						},
						"click.fe_select" : function() {
							if (typeof($mousefocus) == "boolean"){
								$mousefocus = true;
							}
							selectIndex = i;
							comboClose(true);
						}
					});
				});

				$selectTrigger.unbind("keydown.fe_select").bind("keydown.fe_select",function(e) {
					if (e.keyCode==13 || (e.altKey && (e.keyCode == 38 || e.keyCode == 40)) || (e.ctrlKey && (e.keyCode == 38 || e.keyCode == 40))){	//enter
						if ( $selectListWrap.is(":visible") ) {
								comboClose();
						} else {
							comboOpen();
						}
						e.stopPropagation(); 
						return false;
					} else if ( e.keyCode == 9 && e.shiftKey ) {	//shift+tab
						if ($selectTrigger.parent().next().is(":visible")){
							comboClose();
						}
						toStatic();
					} else if ( e.keyCode == 9){ //tab
						if ($selectTrigger.parent().next().is(":visible")){
							comboClose();
						}
						toStatic();
					} else if ( e.keyCode == 38 ) {	//up
						selectIndex = $original.prop("selectedIndex");
						if (Number(selectIndex) > 0){
							selectIndex--;
							$original.find("option:eq("+selectIndex+")").attr("selected", "selected");
							$original.find("option").eq(selectIndex).click();
							$original.change();
							$selectOption.removeClass("activator");
							$selectOption.eq(selectIndex).addClass("activator");
							if(selectIndex == $selectOption.length-1){
								$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
							}else{
								$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
							}
							$currentOption = $selectOption.eq(selectIndex);
							selectValue = $original.find("option:selected").text();
							$selectTrigger.val(selectValue);
							var fixTop = $selectList.scrollTop()+$selectOption.eq(selectIndex).position().top;
							$selectList.scrollTop(fixTop);
						}
						e.stopPropagation(); 
						return false;
					} else if ( e.keyCode == 40 ) {	//down
					
						selectIndex = $original.prop("selectedIndex");
						if (Number(selectIndex)+1 < $selectOption.length){
							selectIndex++;
							$original.find("option:eq("+selectIndex+")").attr("selected", "selected");
							$original.find("option").eq(selectIndex).click();
							$original.change();
							$selectOption.removeClass("activator");
							$currentOption = $selectOption.eq(selectIndex);
							$currentOption.addClass("activator");
							if(selectIndex == $selectOption.length-1){
								$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
							}else{
								$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
							}
							selectValue = $original.find("option:selected").text();
							$selectTrigger.val(selectValue);
							var fixTop = $selectList.scrollTop()+$selectOption.eq(selectIndex).position().top;
							$selectList.scrollTop(fixTop);
						}
						e.stopPropagation(); 
						return false;
					} else if ( e.keyCode == 36) {	//home
						selectIndex = 0;
						$original.find("option:eq("+selectIndex+")").attr("selected", "selected");
						$original.find("option").eq(selectIndex).click();
						$original.change();
						$selectOption.removeClass("activator");
						$currentOption = $selectOption.eq(selectIndex);
						$currentOption.addClass("activator");
						if(selectIndex == $selectOption.length-1){
							$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
						}else{
							$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
						}
						selectValue = $original.find("option:selected").text();
						$selectTrigger.val(selectValue);
						$selectList.scrollTop(0);
						e.stopPropagation(); 
						return false;
					} else if ( e.keyCode == 35) {	//end
						selectIndex = $selectOption.length-1;
						$original.find("option:eq("+selectIndex+")").attr("selected", "selected");
						$original.find("option").eq(selectIndex).click();
						$original.change();
						$selectOption.removeClass("activator");
						$currentOption = $selectOption.eq(selectIndex);
						$currentOption.addClass("activator");
						if(selectIndex == $selectOption.length-1){
							$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
						}else{
							$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
						}
						selectValue = $original.find("option:selected").text();
						$selectTrigger.val(selectValue);
						var fixTop = $selectList.scrollTop()+$selectOption.eq(selectIndex).position().top;
						$selectList.scrollTop(fixTop);
						e.stopPropagation(); 
						return false;
					} 
				});
				
				$select.unbind("keydown.fe_select").bind("keydown.fe_select",function(e) {
					if(e.keyCode == 27){
						if ($selectTrigger.parent().next().is(":visible")){
							comboClose();
						}
						e.stopPropagation(); 
						return false;
					}
				});

				$select.unbind("mouseleave.fe_select").bind("mouseleave.fe_select",function() {
					$mousefocus = false;
					if ( $selectListWrap.is(":visible") ) {
						$selectList.attr("aria-expanded","false");
						if ( browser.msie ) {
							if ( browser.version > 8 || browser.version == 8 ) {
								comboClose();
								dropDownHide();
							}
						} else {
							comboClose();
							toStatic();
						}
					}
				});
				$(document).unbind("click.fe_select").bind("click.fe_select", function(e) {
					e.stopPropagation();
					var $target = $(e.target);
					if ( !$selectListWrap.length ) {
						if ( $selectListWrap.is(":visible") ) {
							$selectList.attr("aria-expanded","false");
							$selectListWrap.hide();
							dropDownHide();
							toStatic();
						}
					}
				});
				function dropDownHide() {
					$(".fe_ddListWrap").each(function() {
						$(this).hide();
						$(this).prev(".fe_ddTriggerWrap").removeClass("activator");
					});
				}
				function getOptionHTML(pObj, tg_i, isSub) {
					var strHTML = '';
					$(pObj).children().each(function(i, o) {
						if($(o).hasClass('optMore')) {
							strHTML += '<li id="cb'+tg_i+'-opt'+i+'" role="option" class="cb_option optMore" role="listitem" tabindex="-1">' + $(o).text() + '</li>\n';
						}
						else if(o.tagName.toUpperCase() == 'OPTION') {
							strHTML += '<li id="cb'+tg_i+'-opt'+i+'" role="option" class="cb_option optMore'+(isSub?' sub':'')+'" role="listitem" tabindex="-1">' + $(o).text() + '</li>\n';
						}
						else if(o.tagName.toUpperCase() == 'OPTGROUP') {
							strHTML += '<li class="optgroup">' + $(o).attr('label') + '</li>\n';
							strHTML += getOptionHTML(o, tg_i, true);
						}
					});

					return strHTML;
				}
				function comboClose(valuechange){
					if(valuechange){
						$original.find("option").removeAttr("selected");
						$original.find("option:eq("+selectIndex+")").attr("selected", "selected");
						$original.find("option").eq(selectIndex).click();
						$original.change();
					}
					$selectList.attr("aria-expanded","false");
					$selectOption.removeClass("activator");
					$currentOption = $selectOption.eq(selectIndex);
					$currentOption.addClass("activator");
					if(selectIndex == $selectOption.length-1){
						$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
					}else{
						$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
					}
					selectValue = $original.find("option:selected").text();
					$selectTrigger.val(selectValue);
					$select.css("z-index", "10");
					if ( $selectListWrap.offset().top > $selectListWrap.parent().offset().top){
						$selectListWrap.slideUp(selectAnimationSpeed, function() {
							$selectListWrap.css("z-index", "10");
						});
					}else{
						$selectListWrap.css({"overflow":"hidden"}).show().animate({"top":"0px","height":"0px"},selectAnimationSpeed, function() {
							$selectTrigger.hide().css({"overflow":"","top":"","height":""});
							$selectListWrap.css("z-index", "10");
						});
					}
					toStatic();
				}
				function comboOpen(){
						$selectList.attr("aria-expanded","true");
						toRelative();
						$selectListWrap.hide();
						$select.css("z-index", "500");
						$selectListWrap.css("z-index", "500");
						$selectListWrap.find("ul.fe_selectList").css({"border-top":"1px solid #ccc"});
						$selectListWrap.find(".fe_selectListBottom").remove();
						$selectListWrap.append($selectListBottom);
						if(selectIndex == $selectOption.length-1){
							$selectListWrap.find(".fe_selectListBottom").addClass("bottomHover");
						}else{
							$selectListWrap.find(".fe_selectListBottom").removeClass("bottomHover");
						}
						$selectListWrap.css({"top":"","height":"","overflow":""}).slideDown(selectAnimationSpeed, function() {$selectListWrap.find('li.activator a').focus();});
						dropDownHide();
						$currentOption = $selectOption.eq(selectIndex);
						var fixTop = $selectList.scrollTop()+$selectOption.eq(selectIndex).position(); //2014.04.16 position().top > position(); 으로 변환
						$selectList.scrollTop(fixTop);
				}
			});
		}
	}
	// fe_select Plugin
	$.fn.fe_select = function(method) {
		// Method calling logic
		if ( fe_select_methods[method] ) {
		  return fe_select_methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || !method ) {
		  return fe_select_methods.init.apply( this, arguments );
		} else {
		  $.error( 'Method "' +  method + '" does not exist on this function' );
		}
	};
	// fe_select Defaults
	$.fn.fe_select.defaults = {
		"disableClass" : "disabled"
	};
	/* ***************** // end of fe_select ********************** */

})(jQuery);

function toStatic() {
	var ieCheck = function() {
		if ( browser.msie ) {
			if ( $browser.version < 8 ) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	if ( ieCheck ) {
			// relative -> static
			$(".resultList").find(".resultPage:").not(":first").find(".fe_selectWrap").css("position","static");
			$(".resultList").find(".resultPage:").not(":first").find(".fe_selectWrap").find("p.fe_select_triggerWrap").css("position","static");
			$(".resultList").find(".resultPage:").not(":first").find(".pageArray").css("position", "static");
			$(".resultList").find(".resultpage").not(":first").css("position","static");
	}
}

	/* *****************  input custom********************** */

function toRelative() {
	var ieCheck = function() {
		if ( browser.msie ) {
			if ( $browser.version < 8 ) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	if ( ieCheck ) {
		// relative -> static
		$(".resultList").find(".resultPage:").not(":first").find(".fe_selectWrap").css("position","relative");
		$(".resultList").find(".resultPage:").not(":first").find(".fe_selectWrap").find("p.fe_select_triggerWrap").css("position","relative");
	}
}

jQuery.fn.customInput = function(){
	$(this).each(function(i){	
		if($(this).is('[type=checkbox],[type=radio]')){
			var input = $(this);
			
			// get the associated label using the input's id
			var label = $('label[for='+input.attr('id')+']');
			
			//get type, for classname suffix 
			var inputType = (input.is('[type=checkbox]')) ? 'checkbox' : 'radio';
			
			// wrap the input + label in a div 
			$('<div class="custom-'+ inputType +'"></div>').insertBefore(input).append(input, label);
			
			// find all inputs in this set using the shared name attribute
			var allInputs = $('input[name='+input.attr('name')+']');
			
			// necessary for browsers that don't support the :hover pseudo class on labels
			label.hover(
				function(){ 
					$(this).addClass('hover'); 
					if(inputType == 'checkbox' && input.is(':checked')){ 
						$(this).addClass('checkedHover'); 
					} 
				},
				function(){ $(this).removeClass('hover checkedHover'); }
			);
			
			//bind custom event, trigger it, bind click,focus,blur events					
			input.bind('updateState', function(){	
				if (input.is(':checked')) {
					if (input.is(':radio')) {				
						allInputs.each(function(){
							$('label[for='+$(this).attr('id')+']').removeClass('checked');
						});		
					};
					label.addClass('checked');
				}
				else { label.removeClass('checked checkedHover checkedFocus'); }
										
			})
			.trigger('updateState')
			.click(function(){ 
				$(this).trigger('updateState'); 
			})
			.focus(function(){ 
				label.addClass('focus'); 
				if(inputType == 'checkbox' && input.is(':checked')){ 
					$(this).addClass('checkedFocus'); 
				} 
			})
			.blur(function(){ label.removeClass('focus checkedFocus'); });
		}
	});
};
		$(document).ready(function(){
			var isios=(/(ipod|iphone|ipad)/i).test(navigator.userAgent);//ios
			var isipad=(/(ipad)/i).test(navigator.userAgent);//ipad
			var isandroid=(/android/i).test(navigator.userAgent);//android
			if(!isios && !isipad && !isandroid){
				// designed combobox
				 if ( $("select").length) {
					$("select").fe_select();
				}
			}
		});