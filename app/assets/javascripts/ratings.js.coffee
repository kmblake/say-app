# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->

  $("#rating-select").change ->
    $(".edit_rating, .new_rating").submit()
    $("#rating-select option[value='']").remove()
    $('select').prop("disabled", true)
    $("#rating-info").html("Saving...")


  $(".edit_rating, .new_rating").on("ajax:success", (e, rating, status, xhr) ->
    $('select').prop("disabled", false)
    $("#rating-info").html("Rating saved: " + rating.rating_val)
    newForm = $(".new_rating")
    if newForm?
      id = rating.id
      oldAction = newForm.attr("action")
      newForm.attr("action", oldAction + "/" + id)
      $(".new_rating :first-child :first-child").append('<input name="_method" type="hidden" value="patch">')
      newForm.removeClass('new_rating')
      newForm.addClass('edit_rating')
    ).on "ajax:error", (e, xhr, status, error) ->
      $(".info").html("<div class='alert alert-danger'>Rating update failed.  Reload the page to see the current rating.</div>")
