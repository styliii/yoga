# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(document).keydown (e) ->
		if e.keyCode is 37
			$('span.prev_day a').click()
			false
  $(document).keydown (e) -> 
    if e.keyCode is 39
      $('span.next_day a').click()
      false