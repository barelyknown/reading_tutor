$(document).on "click", "div.word-navigation", (event) ->
  Turbolinks.visit $(this).data("url")

$(document).on "click", ".say-word", (event) ->
  if window["speechSynthesis"]?
    speechSynthesis.speak(new SpeechSynthesisUtterance($(this).data("word")))

$ ->

  $(".say-word").addClass("disabled") unless window["speechSynthesis"]?
