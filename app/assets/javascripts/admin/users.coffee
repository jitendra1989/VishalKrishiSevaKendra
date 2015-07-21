# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
usersReady = ->
	$('.role-selector').change (e) ->
		$(".permissions-#{$(this).val()} input").prop 'checked', $(this).prop('checked')
		return
	return

$(document).ready(usersReady)
$(document).on('page:load', usersReady)
