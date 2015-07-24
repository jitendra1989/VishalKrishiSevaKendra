# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	$('.product-thumbnail').click (e) ->
		$('.product-medium').attr 'src', $(this).data('medium-url')
		return
	return

$(document).ready(productsReady)
$(document).on('page:load', productsReady)
