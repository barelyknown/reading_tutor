$(document).on "click", ".syllables-placeholder", (event) ->
  $.ajax(url: $(this).data("url"), dataType: "script").always (data) =>
    $(this).html($(data.responseText).html())
    $(this).removeClass("syllables-placeholder")
    $(this).addClass("syllables")