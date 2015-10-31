# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
reportsReady = ->
	$('#from_date').datetimepicker
		format: 'Y/m/d'
		onShow: (ct) ->
			@setOptions maxDate: if $('#to_date').val() then $('#to_date').val() else false
			return
		timepicker: false
	$('#to_date').datetimepicker
		format: 'Y/m/d'
		onShow: (ct) ->
			@setOptions minDate: if $('#from_date').val() then $('#from_date').val() else false
			return
		timepicker: false
	return

$(document).on('ready page:load', reportsReady)
