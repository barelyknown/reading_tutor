$(document).on "click", "div.word-navigation", (event) ->
  Turbolinks.visit $(this).data("url")

$(document).on "click", ".say-word", (event) ->
  if window["speechSynthesis"]?
    speech = new SpeechSynthesisUtterance()
    speech.text = $(this).data("word")
    speech.volume = 1 # 0 to 1
    speech.rate = 0.5 # 0.1 to 9
    speech.pitch = 1 # 0 to 2, 1=normal
    speech.lang = "en-US"
    speechSynthesis.speak(speech)

$(document).on "click", ".random-word-links .well", (event) ->
  Turbolinks.visit $(this).data("url")

$ ->

  $(".say-word").addClass("disabled") unless window["speechSynthesis"]?
