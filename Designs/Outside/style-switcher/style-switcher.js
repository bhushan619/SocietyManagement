/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2006, 2014 Klaus Hartl
 * Released under the MIT license
 */

!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof exports?a(require("jquery")):a(jQuery)}(function(a){function c(a){return h.raw?a:encodeURIComponent(a)}function d(a){return h.raw?a:decodeURIComponent(a)}function e(a){return c(h.json?JSON.stringify(a):String(a))}function f(a){0===a.indexOf('"')&&(a=a.slice(1,-1).replace(/\\"/g,'"').replace(/\\\\/g,"\\"));try{return a=decodeURIComponent(a.replace(b," ")),h.json?JSON.parse(a):a}catch(c){}}function g(b,c){var d=h.raw?b:f(b);return a.isFunction(c)?c(d):d}var b=/\+/g,h=a.cookie=function(b,f,i){if(arguments.length>1&&!a.isFunction(f)){if(i=a.extend({},h.defaults,i),"number"==typeof i.expires){var j=i.expires,k=i.expires=new Date;k.setTime(+k+864e5*j)}return document.cookie=[c(b),"=",e(f),i.expires?"; expires="+i.expires.toUTCString():"",i.path?"; path="+i.path:"",i.domain?"; domain="+i.domain:"",i.secure?"; secure":""].join("")}for(var l=b?void 0:{},m=document.cookie?document.cookie.split("; "):[],n=0,o=m.length;o>n;n++){var p=m[n].split("="),q=d(p.shift()),r=p.join("=");if(b&&b===q){l=g(r,f);break}b||void 0===(r=g(r))||(l[q]=r)}return l};h.defaults={},a.removeCookie=function(b,c){return void 0===a.cookie(b)?!1:(a.cookie(b,"",a.extend({},c,{expires:-1})),!a.cookie(b))}});

/* Style Switcher
 * Author: Anuvaa Softech Private Limited
 * Author URI:http://www.anuvaasoft.com
 * Author e-mail:anuvaasoft.com@gmail.com
 * Version:1.2.0
 * Created:20 May 2014
 * Updated:19 Oct 2014
 * File Description: Style Switcher
 */

jQuery(document).ready(function($) {

		//SIDE PANEL 
		//--------------------------------------------------------
		style_switcher = $('.style-switcher'),
		panelWidth = style_switcher.outerWidth(true);
			
		$('.style-switcher .trigger').on("click", function(){
			var $this = $(this);
			if ($(".style-switcher.closed").length>0) {
				style_switcher.animate({"left" : "0px"});
				$(".style-switcher.closed").removeClass("closed");
				$(".style-switcher").addClass("opened");
				$(".style-switcher .trigger i").removeClass("icon-cog-1").addClass("fa fa-times");
			} else {
				$(".style-switcher.opened").removeClass("opened");
				$(".style-switcher").addClass("closed");
				$(".style-switcher .trigger i").removeClass("fa fa-times").addClass("icon-cog-1");
				style_switcher.animate({"left" : '-' + panelWidth});
			}
			return false;
		});
		
		// style change 
		var link = $('link[data-style="styles"]'),
		link_no_cookie = $('link[data-style="styles-no-cookie"]');

		// resume last chosen style
		var tp_stylesheet = $.cookie('tp_stylesheet'),
			footer_bg = $.cookie('footer_bg'),
			tp_layout_mode = $.cookie('tp_layout_mode'),		
			pattern = $.cookie('pattern');

		$(".style-switcher .selected").removeClass("selected");
		if (!($.cookie('tp_stylesheet'))) {
			$.cookie('tp_stylesheet', 'light_blue', 365);
			tp_stylesheet = $.cookie('tp_stylesheet');
			$('.style-switcher .styleChange li[data-style="'+tp_stylesheet+'"]').addClass("selected");
		} else {
			if (link.length>0) {
				link.attr('href','css/skins/' + tp_stylesheet + '.css');
				$('.style-switcher .styleChange li[data-style="'+tp_stylesheet+'"]').addClass("selected");
				if ($(".header-page-dark").length>0) {
					document.getElementById("logo_img").src="images/logo_dark_header_" + tp_stylesheet + ".png";
				} else {
					if ($("#logo_img").length>0) {
						document.getElementById("logo_img").src="images/logo_" + tp_stylesheet + ".png";
					};
					if ($("#logo-footer").length>0) {
						document.getElementById("logo-footer").src="images/logo_" + tp_stylesheet + ".png";
					};
				};
			};
		};

		if (!($.cookie('tp_layout_mode'))) {
			$.cookie('tp_layout_mode', 'wide', 365);
			tp_layout_mode = $.cookie('tp_layout_mode');
			$("body").addClass(tp_layout_mode);
			$('.style-switcher .layoutChange li[data-style="wide"]').addClass("selected");
		} else {
			if (tp_layout_mode=="boxed") {
				$("body").addClass(tp_layout_mode);
				$("body").removeClass("wide");
				$('.style-switcher .layoutChange li[data-style="boxed"]').addClass("selected");
				$('.style-switcher .layoutChange li[data-style="wide"]').removeClass("selected");
				$(".owl-carousel .container").css("marginLeft", "0");
			} else { 
				$("body").addClass(tp_layout_mode);
				$("body").removeClass("boxed pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9");
				$('.style-switcher .layoutChange li[data-style="boxed"]').removeClass("selected");
				$('.style-switcher .layoutChange li[data-style="wide"]').addClass("selected");
				$(".owl-carousel .container").css("marginLeft", "auto");
			};
		};

		if ((tp_layout_mode =="boxed") && $.cookie('pattern')) {
			$('.style-switcher .patternChange li[data-style="'+pattern+'"]').addClass("selected");
			$("body").removeClass("pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9 wide");
			$("body").addClass(pattern); 
		} else if (tp_layout_mode =="boxed") {
			$("body").removeClass("pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9");
			$('.style-switcher .patternChange li[data-style="pattern-0"]').addClass("selected");
		} else {
			$('.style-switcher .patternChange li.selected').removeClass("selected");
			$("body").removeClass("pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9 boxed");
		};

		if (!($.cookie('footer_bg'))) {
			$.cookie('footer_bg', 'dark', 365);
			footer_bg = $.cookie('footer_bg');
			$('.style-switcher .footerChange li[data-style="dark"]').addClass("selected");
		} else {
			if (footer_bg=="dark") {
				$("#footer").removeClass("light");
				$('.style-switcher .footerChange li[data-style="dark"]').addClass("selected");
				$('.style-switcher .footerChange li[data-style="light"]').removeClass("selected");
			} else { 
				$("#footer").addClass("light");
				$('.style-switcher .footerChange li[data-style="dark"]').removeClass("selected");
				$('.style-switcher .footerChange li[data-style="light"]').addClass("selected");
			};
		};

		// switch colors
		$('.style-switcher .styleChange li').on('click',function(){
			if (link.length>0) {
				var $this = $(this),
					tp_stylesheet = $this.data('style');
				$(".style-switcher .styleChange .selected").removeClass("selected");
				$this.addClass("selected");
				link.attr('href', 'css/skins/' + tp_stylesheet + '.css');
				if ($(".header-page-dark").length>0) {
					document.getElementById("logo_img").src="images/logo_dark_header_" + tp_stylesheet + ".png";
				} else {
					if ($("#logo_img").length>0) {
						document.getElementById("logo_img").src="images/logo_" + tp_stylesheet + ".png";
					};
					if ($("#logo-footer").length>0) {
						document.getElementById("logo-footer").src="images/logo_" + tp_stylesheet + ".png";
					};
				};
				$.cookie('tp_stylesheet', tp_stylesheet, 365);
			} else {
				var $this = $(this),
					tp_stylesheet_no_cookie = $this.data('style');
				$(".style-switcher .styleChange .selected").removeClass("selected");
				$this.addClass("selected");
				link_no_cookie.attr('href', 'css/skins/' + tp_stylesheet_no_cookie + '.css');
				if ($(".header-page-dark").length>0) {
					document.getElementById("logo_img").src="images/logo_dark_header_" + tp_stylesheet_no_cookie + ".png";
				} else {
					if ($("#logo_img").length>0) {
						document.getElementById("logo_img").src="images/logo_" + tp_stylesheet_no_cookie + ".png";
					};
					if ($("#logo-footer").length>0) {
						document.getElementById("logo-footer").src="images/logo_" + tp_stylesheet_no_cookie + ".png";
					};
				};
			};
		});

		// switch patterns
		$('.style-switcher .patternChange li').on('click',function(){
		var $this = $(this),
			pattern = $this.data('style');
		$(".style-switcher .patternChange .selected").removeClass("selected");
		$this.addClass("selected");
		$("body").removeClass("pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9 wide");
		$("body").addClass(pattern);
		$("body").addClass("boxed");
		$('.style-switcher .layoutChange li[data-style="boxed"]').addClass("selected");
		$('.style-switcher .layoutChange li[data-style="wide"]').removeClass("selected");
		$(".owl-carousel .container").css("marginLeft", "0");
		$(".style-switcher select").val("boxed");
		$.cookie('pattern', pattern, 365);
		$.cookie('tp_layout_mode', 'boxed', 365);
		});

		// Switch layout
		// Boxed Layout
		$('.style-switcher .layoutChange li.boxed').on('click',function(){ 
			$("body").addClass("boxed");
			$("body").removeClass("wide");
			$('.style-switcher .layoutChange li[data-style="boxed"]').addClass("selected");
			$('.style-switcher .layoutChange li[data-style="wide"]').removeClass("selected");
			$(".owl-carousel .container").css("marginLeft", "0");
			$.cookie('tp_layout_mode', 'boxed', 365);
			if ($.cookie('pattern')) {
				var pattern = $.cookie('pattern');
				$('.style-switcher .patternChange li[data-style="'+pattern+'"]').addClass("selected");
				$("body").removeClass("pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9");
				$("body").addClass(pattern);
			} else {
				$('.style-switcher .patternChange li[data-style="pattern-0"]').addClass("selected");
			}
		});

		// Wide Layout
		$('.style-switcher .layoutChange li.wide').on('click',function(){ 
			$("body").addClass("wide");
			$("body").removeClass("boxed pattern-0 pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9");
			$('.style-switcher .layoutChange li[data-style="boxed"]').removeClass("selected");
			$('.style-switcher .layoutChange li[data-style="wide"]').addClass("selected");
			$(".owl-carousel .container").css("marginLeft", "auto");
			$('.style-switcher .patternChange li.selected').removeClass("selected");
			$.cookie('tp_layout_mode', 'wide', 365);
		});

		// Footer bg
		$('.style-switcher .footerChange li.dark').on('click',function(){ 
			$("#footer").removeClass("light");
			$('.style-switcher .footerChange li[data-style="dark"]').addClass("selected");
			$('.style-switcher .footerChange li[data-style="light"]').removeClass("selected");
			$.cookie('footer_bg', 'dark', 365);
		});

		$('.style-switcher .footerChange li.light').on('click',function(){ 
			$("#footer").addClass("light");
			$('.style-switcher .footerChange li[data-style="dark"]').removeClass("selected");
			$('.style-switcher .footerChange li[data-style="light"]').addClass("selected");
			$.cookie('footer_bg', 'light', 365);
		});

		//Reset All
		$('.style-switcher .resetAll li.btn-dark').on('click',function() { 
			// footer bg
			$.cookie('footer_bg', 'dark', 365);
			$("#footer").removeClass("light");
			$('.style-switcher .footerChange li[data-style="dark"]').addClass("selected");
			$('.style-switcher .footerChange li[data-style="light"]').removeClass("selected");
			// layout mode
			$.cookie('tp_layout_mode', 'wide', 365);
			$("body").addClass("wide");
			$("body").removeClass("boxed");
			$('.style-switcher .layoutChange li[data-style="boxed"]').removeClass("selected");
			$('.style-switcher .layoutChange li[data-style="wide"]').addClass("selected");
			$(".owl-carousel .container").css("marginLeft", "auto");
			$('.style-switcher .patternChange li.selected').removeClass("selected");
			//pattern
			$.cookie('pattern', 'pattern-0', 365);
			$("body").removeClass("reset pattern-1 pattern-2 pattern-3 pattern-4 pattern-5 pattern-6 pattern-7 pattern-8 pattern-9");
			$(".style-switcher .patternChange .selected").removeClass("selected");
			//Stylesheet
			$.cookie('tp_stylesheet', 'light_blue', 365);
			var tp_stylesheet = $.cookie('tp_stylesheet');
			$('.style-switcher .styleChange li.selected').removeClass("selected");
			$('.style-switcher .styleChange li[data-style="'+tp_stylesheet+'"]').addClass("selected");
			link.attr('href', 'css/skins/' + tp_stylesheet + '.css');
			if ($("#logo_img").length>0) {
				document.getElementById("logo_img").src="images/logo_" + tp_stylesheet + ".png";
			};
			if ($("#logo-footer").length>0) {
				document.getElementById("logo-footer").src="images/logo_" + tp_stylesheet + ".png";
			};
		});

});    	