# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
requirementsReady = ->
	if $('.requirement-item-customiser').length > 0
		camera_open = false
		# Grab elements, create settings, etc.
		canvas = document.getElementById('canvas')
		context = canvas.getContext('2d')
		video = document.getElementById('video')
		errBack = (error) ->
			console.log 'Video capture error: ', error.code
			return
		convertCanvasToImage = (canvas) ->
			return canvas.toDataURL('image/png')
		access_camera = ->
			$('.camera-box').removeClass 'hidden'
			$('.camera-inactive').removeClass 'camera-inactive'
			$('.open-camera').hide()
			camera_open = true
			captureUserMedia = ->
				# Put video listeners into place
				if navigator.getUserMedia
					# Standard
					navigator.getUserMedia {video: true}, ((stream) ->
						video.src = stream
						video.play()
						return
					), errBack
				else if navigator.webkitGetUserMedia
					# WebKit-prefixed
					navigator.webkitGetUserMedia {video: true}, ((stream) ->
						video.src = window.webkitURL.createObjectURL(stream)
						video.play()
						return
					), errBack
				else if navigator.mozGetUserMedia
					# Firefox-prefixed
					navigator.mozGetUserMedia {video: true}, ((stream) ->
						video.src = window.URL.createObjectURL(stream)
						video.play()
						return
					), errBack
					return
			captureUserMedia()
			return
		$('.open-camera').click ->
			access_camera() unless camera_open
			return
		$(document).on 'click', '.click-camera', ->
			context.drawImage video, 0, 0, 640, 480
			object_id = $(this).data('id')
			$('.alert-camera').removeClass 'hidden'
			$(".file_uploader_#{object_id}").val('')
			$(".file_uploader_#{object_id}").next('.filename').html('')
			$("#clicked_image_#{object_id}").attr 'src', convertCanvasToImage(canvas)
			$("#image_data_uri_#{object_id}").val(convertCanvasToImage(canvas))
			return
	return
$(document).on('ready page:load', requirementsReady)
