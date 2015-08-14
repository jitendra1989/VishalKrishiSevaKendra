# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	if $('.order-conditions').length
		$('#terms').change ->
			$('.payment-gateway').prop 'disabled', !$(this).is(':checked')
			return
	return

$(document).on('ready page:load', productsReady)
