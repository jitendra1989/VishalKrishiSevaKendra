# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
receiptsReady = ->
	$('#receipt_payment_method').change ->
		$('.payment-info').addClass 'hidden'
		$(".payment-info-#{$(this).val()}").removeClass 'hidden'
		return
	return

$(document).on('ready page:load', receiptsReady)
