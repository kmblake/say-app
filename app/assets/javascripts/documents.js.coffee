ready = -> 
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    onButtonLoad(data)

onButtonLoad = (accepted) ->
  $("#accept-button").toggleClass("btn-danger btn-success")
  if accepted 
    $("#accept-button").html("Reject")
  else
    $("#accept-button").html("Accept")
  
$(document).ready(ready)
$(document).on('page:load', ready)
