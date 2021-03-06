ready = -> 
  $("#accept-button").on "ajax:success", (e, data, status, xhr) ->
    onButtonLoad(data)

  $("#flag").on "ajax:success", (e, data, status, xhr) ->
    toggleFlag(data)

toggleFlag = (flagged) ->
  $("#flag-icon").toggleClass("red weak")

onButtonLoad = (accepted) ->
  $("#accept-button").toggleClass("btn-danger btn-success")
  if accepted 
    $("#accept-button").html("Reject")
  else
    $("#accept-button").html("Accept")
  
$(document).ready(ready)
$(document).on('page:load', ready)
