# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	$('#slider').nivoSlider
		pauseOnHover: false
		prevText: '<'
		nextText: '>'
	$('.product-thumbnail').click (e) ->
		$('.product-medium').attr('src', $(this).data('medium-url'))
		.data('large-url', $(this).data('large-url')).data('medium-url', $(this).data('medium-url'))
		return
	$('.zoom-image').click (e) ->
		zoomed = $(this).hasClass('zoom-out')
		if zoomed
			$(this).attr('src', $(this).data('medium-url'))
		else
			$(this).attr('src', $(this).data('large-url'))
		$(this).toggleClass('zoom-out')
		return
	return


$(document).ready(productsReady)
$(document).on('page:load', productsReady)
