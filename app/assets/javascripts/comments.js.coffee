# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->

  $("#comment-text").keydown( (e) ->
    if e.keyCode == 13
      $("#new_comment").submit()
    )

  $("#new_comment").on("ajax:success", (e, data, status, xhr) ->
    # message = if rating.rating_val? then "Rating saved: " + rating.rating_val else "Rating reset"
    $("#comment-text").val("")
    $("#title-suggestion").attr('checked', false)
    ).on "ajax:error", (e, xhr, status, error) ->
      errors = $.parseJSON(xhr.responseText).errors
      $(".info").html("<div class='alert alert-danger'>Comment did not save.  Please try again. Errors: " + errors + "</div>")