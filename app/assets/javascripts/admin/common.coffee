# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
commonReady = ->
	$('[data-toggle="tooltip"]').tooltip() if $('.has-tooltip').length > 0
	$('.file-upload').change ->
		$(this).next('.filename').html("Attached: #{$(this).val()}")
		return
	return

$(document).on('ready page:load', commonReady)
