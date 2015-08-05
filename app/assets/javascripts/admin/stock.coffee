# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
StockReady = ->
	$('#stock_invoice_date').datetimepicker
	  timepicker: false
	  format: 'd/m/Y'

$(document).on('ready page:load', StockReady)