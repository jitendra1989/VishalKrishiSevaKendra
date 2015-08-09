# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
cartsReady = ->
	calculateTotals = ->
		subtotal = parseFloat $('.subtotal').data('subtotal')
		percent = parseFloat $('.cart-discount-percent').val()
		discount = Math.round(subtotal * percent/100)
		$('.cart-discount-amount').val(discount)
		$('.full-total').html(Math.round((subtotal - discount)*100)/100)
		$('.cart-discount').html(discount)
		return
	$('.cart-discount-percent').bind 'keyup change', ->
		calculateTotals()
		return
	return

$(document).ready(cartsReady)
$(document).on('page:load', cartsReady)
