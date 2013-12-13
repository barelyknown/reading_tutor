$(document).on "click", "button.show-syllables", (event) ->
  $.ajax(url: $(this).data("url"), dataType: "script").always (data) =>
    $(this).closest(".word").find(".letters").html($(data.responseText).html())
    $(this).addClass("disabled")