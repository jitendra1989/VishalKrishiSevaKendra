# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
quotationsReady = ->
	calculateTotals = (percentage) ->
		subtotal = 0
		$('.quantity-field').each ->
			quantity = parseInt $(this).val()
			price = parseFloat $(this).parent().next().html()
			amount = Math.round(quantity * price*100)/100
			subtotal += amount
			$(this).parent().next().next().html(amount)
			return
		if percentage
			percent = parseFloat $('.discount-percent').val()
			discount = Math.round(subtotal * percent/100)/100
			$('#quotation_discount_amount').val(discount)
		else
			discount = parseFloat $('#quotation_discount_amount').val()
			percent = Math.round((discount * 100/ subtotal) * 100)/100
			$('.discount-percent').val(percent)

		$('.sub-total').html(subtotal)
		$('.full-total').html(Math.round((subtotal - discount)*100)/100)
		return
	$('.autocomplete').tinyAutocomplete
		url: $('.autocomplete').data('url')
		onSelect: (el, val) ->
			$(this).val(val.title)
			$(this).data 'id', val.id
			$(this).data 'price', val.price
			$('.add-product').removeClass 'hidden'
			return
	$('.quotation-products').on 'cocoon:after-insert', (e, insertedItem) ->
		$(insertedItem).find('.product-id').val($('#product').data('id'))
		$(insertedItem).find('.product-name').html($('#product').val())
		$(insertedItem).find('.product-rate').html($('#product').data('price'))
		$('#product').val ''
		$('.add-product').addClass 'hidden'
		return
	$(document).on 'keyup', '.quantity-field, .discount-percent, #quotation_discount_amount', ->
		calculateTotals($(this).hasClass 'discount-percent')
		return
	return

$(document).ready(quotationsReady)
$(document).on('page:load', quotationsReady)
