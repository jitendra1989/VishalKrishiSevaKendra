# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
cartsReady = ->
	calculateTotals = (percentage) ->
		subtotal = parseFloat $('.subtotal').data('subtotal')
		if percentage
			percent = parseFloat $('.cart-discount-percent').val()
			discount = Math.round(subtotal * percent/100)
			$('.cart-discount-amount').val(discount)
		else
			discount = parseFloat $('.cart-discount-amount').val()
			percent = Math.round((discount * 100/ subtotal) * 100)/100
			$('.cart-discount-percent').val(percent)
		$('.full-total').html(Math.round((subtotal - discount)*100)/100)
		return
	$('.cart-discount-amount, .cart-discount-percent').keyup ->
		calculateTotals($(this).hasClass 'cart-discount-percent')
		return
	return

$(document).ready(cartsReady)
$(document).on('page:load', cartsReady)
