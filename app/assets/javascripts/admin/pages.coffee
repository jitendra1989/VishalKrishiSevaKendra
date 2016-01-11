# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
pagesReady = ->
	if ('#content_page_content').length > 0
		$('#content_page_content').froalaEditor()
	return

$(document).ready(pagesReady)
$(document).on('page:load', pagesReady)
