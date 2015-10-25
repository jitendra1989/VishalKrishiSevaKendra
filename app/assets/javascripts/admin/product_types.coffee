# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
productTypesReady = ->
	if $('#taxes-list').length > 0
		$(document).on 'click', '.sub-tax-adder', (e) ->
			$('.tax-adder').data('association-insertion-node', $(this).data('association-insertion-node'))
			$('.tax-adder').trigger('click')
			e.preventDefault()
			return
		$('#taxes-list').on 'cocoon:after-insert', (e, added_task) ->
			parent = String(added_task.parent().data('parent'))
			if parent != 'undefined'
				added_task.find('.tax-parent-id').val(parent.replace(/_/g, ''))
			return
	return

$(document).on('ready page:load', productTypesReady)
