$(document).on "click", "a[name='play-ios-sample-sounds']", (event) ->
  event.preventDefault()
  for rate in [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,2.0,5.0]
    speech = new SpeechSynthesisUtterance()
    speech.text = "How fast is #{rate}?"
    speech.rate = rate
    speechSynthesis.speak(speech)
