# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	if $('.zoom-image').length
		$('.zoom-image').elevateZoom
			gallery: 'thumbnail-gallery'
			cursor: 'pointer'
			scrollZoom : true
			zoomWindowOffetx: 20
			zoomWindowOffety: -50
			galleryActiveClass: 'active-image'
			imageCrossfade: true
		$('.zoom-image').bind 'click', (e) ->
			$('.zoomed-image').attr('src', $('.active-image').data('zoom-image'))
			$('.images-modal').modal('show')
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
