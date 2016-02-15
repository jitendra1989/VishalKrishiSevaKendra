frontReady = ->
	menu = $('.navbar-default')
	offsetY = menu.offset().top
	scrollMenu = ->
		if $(window).scrollTop() >= offsetY
			$('.navbar-default').addClass('navbar-fixed-top')
			$('.content').addClass('menu-padding')
		else
			$('.navbar-default').removeClass('navbar-fixed-top')
			$('.content').removeClass('menu-padding')
		return
	$(document).on('scroll', scrollMenu)

	return


$(document).ready(frontReady)
$(document).on('page:load', frontReady)
