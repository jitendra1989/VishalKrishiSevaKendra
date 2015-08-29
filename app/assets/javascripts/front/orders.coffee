# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productsReady = ->
  formatTime = (unit) ->
    "0#{unit}".slice(-2)
  timeCount = (seconds, minutes, hours, classDiv) ->
    view_minutes = if minutes < 10 then '0' + minutes else minutes
    view_seconds = if seconds < 10 then '0' + seconds else seconds
    view_hours = if hours < 10 then '0' + hours else hours
    $(classDiv).html formatTime(hours) + ':' + formatTime(minutes) + ':' + formatTime(seconds)
    seconds--
    if seconds < 0
      minutes--
      seconds = 59
      if minutes < 0
        hours--
        minutes = 59
    t = setTimeout(timeCount, 1000, seconds, minutes, hours, classDiv) unless (hours == 0 && minutes == 0 && seconds == 0)
    return
  if $('.stock-block').length
    runningTime = $('.stock-block').text().split(":").map(Number)
    timeCount(runningTime[2], runningTime[1], runningTime[0], '.stock-block')
    setTimeout (->
      Turbolinks.visit $('.stock-block').data('redirect-path')
      return
    ), (parseInt($('.stock-block').data('seconds')) * 1000) + 500
  if $('.order-conditions').length
    $('#terms').change ->
      $('.payment-gateway').prop 'disabled', !$(this).is(':checked')
      return
    $('#terms').trigger 'change'
  return

$(document).on('ready page:load', productsReady)
