# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ordersReady = ->
	$('.flag-adder').click (e) ->
		comment_field = $("##{$(this).data('comment')}")
		if comment_field.hasClass('hidden')
			comment_field.removeClass 'hidden'
			$(this).toggleClass('btn-link btn-default').text('Submit')
			e.preventDefault()
		return
	return

$(document).on('ready page:load', ordersReady)
