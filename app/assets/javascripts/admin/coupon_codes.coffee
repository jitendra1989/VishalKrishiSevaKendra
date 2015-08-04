# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
couponCodesReady = ->
	$('#coupon_code_active_from').datetimepicker
	  format: 'd/m/Y H:i'
	  onShow: (ct) ->
	    @setOptions maxDate: (if $('#coupon_code_active_to').val() then $('#coupon_code_active_to').val() else false)
	    return
	  timepicker: true
	$('#coupon_code_active_to').datetimepicker
	  format: 'd/m/Y H:i'
	  onShow: (ct) ->
	    @setOptions minDate: (if $('#coupon_code_active_from').val() then $('#coupon_code_active_from').val() else false)
	    return
	  timepicker: true
	return

$(document).on('ready page:load', couponCodesReady)
