# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
	$(document).on 'change', '.characteristic-changer', (e) ->
		url = $(this).data('url').replace('0', $(this).val())
		uid = $(this).data('uid')[0]
		invoker = $(this).data('invoker')
		target = $(this).parent().siblings('.characteristic-image')
		$.get url, { uid: uid, invoker: invoker }, (data) ->
			target.html(data)
			return
		return
	return

$(document).on('ready page:load', productsReady)
