play_audio = (audio, delay) ->
  setTimeout((-> audio.play()), delay)

(exports ? this).make_audio_controls_visible = ->
  $(".say-word").removeClass("say-word-loading")
  $(".say-word").addClass("say-word-loaded")

$(document).on "click", "div.say-word", (event) ->
  event.preventDefault()
  delay = 0
  $("audio").each (i) ->
    play_audio($(this)[0], delay)
    delay += parseInt($(this).data("milliseconds")) * 2

$(document).on "click", "div.word-navigation", (event) ->
  Turbolinks.visit $(this).data("url")

$ ->
  if $("audio").length == 0
    $("div.say-word").hide()