# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('li.class-info').on 'click', ->
    $(this).find('.teacher-review').slideToggle()
    $(this).find('.studio-review').slideToggle()        

  $('.arrow-down').click ->
    $('.cover-copy').fadeOut()
    $('.arrow-down').fadeOut()
    $('.cover-container').slideUp()
