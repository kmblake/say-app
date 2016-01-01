# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->

  $("#rating-select").change ->
    $(".edit_rating, .new_rating").submit()

  $(".edit_rating, .new_rating").on("ajax:success", (e, rating, status, xhr) ->
    console.log(rating)
    $("#rating-info").html("Rating saved: " + rating.rating_val)
    ).on "ajax:error", (e, xhr, status, error) ->
      $(".info").html("<div class='alert alert-danger'>Rating update failed.  Reload the page to see the current rating.</div>")
