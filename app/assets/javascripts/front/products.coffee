# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	if $('.zoom-image').length
		$('.zoom-image').elevateZoom
			scrollZoom: true
			gallery: 'thumbnail-gallery'
			cursor: 'pointer'
			zoomWindowOffetx: 20
			zoomWindowOffety: -50
			galleryActiveClass: 'active-image'
		$('.zoom-image').bind 'click', (e) ->
			$.fancybox $('.zoom-image').data('elevateZoom').getGalleryList()
			return false
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next a').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 80
				$('.pagination').text 'Loading more products...'
				$.getScript(url)
		$(window).scroll()
	if $('#slider').length
		$('#slider').nivoSlider
			pauseOnHover: false
			prevText: '<'
			nextText: '>'
	return


$(document).ready(productsReady)
$(document).on('page:load', productsReady)
