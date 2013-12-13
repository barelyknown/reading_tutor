# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:complete", "a.word-definitions", (event, xhr, settings) ->
  $(this).closest(".word").find(".panel-letters").append($(xhr.responseText))
  $(this).addClass("disabled")