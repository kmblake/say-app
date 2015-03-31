$(document).on "page:change", ->
  $('input[name="accepting_submissions"]').on 'switchChange.bootstrapSwitch', (event, state) -> 
    $('#submissions_switch').submit()

  $("#submissions_switch").on("ajax:success", (e, data, status, xhr) ->
  ).on "ajax:error", (e, xhr, status, error) ->
    $(".info").html("<div class='alert alert-danger'>Setting update failed.  Reload the page to see the current settings.></div>")

  $('input[name="finalized"]').on 'switchChange.bootstrapSwitch', (event, state) -> 
    $('#finalized_switch').submit()

  $("#finalized_switch").on("ajax:success", (e, data, status, xhr) ->
  ).on "ajax:error", (e, xhr, status, error) ->
    $(".info").html("<div class='alert alert-danger'>Setting update failed.  Reload the page to see the current settings.</div>")

  # $('#loading-btn').on 'click', () ->
  #   alert("Clicked")
  #   $(this).button('loading')


  # $("#loading-btn").on("ajax:success", (e, data, status, xhr) ->
  #   $btn.button('reset')
  # ).on "ajax:error", (e, xhr, status, error) ->
  #   $btn.button('reset')
  #   $(".info").html("<div class='alert alert-danger'>Download failed.  Please try again.</div>")


