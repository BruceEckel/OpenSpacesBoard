# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$(document).ready ->
  #Handle clicking on a spacetime block on board/show
  $("td.can-add").click ->
    #Grab the spacetime ID from the board display so we know where the topic should live
    spaceTimeId = $(this).attr("id")
    room = $(this).attr("data-room")
    time = $(this).attr("data-time")

    #Set a callback for once the modal dialog is loaded, and add the spacetime ID to a hidden field
    #There is currently a documented (and fixed) bug in bootstrap 3.0
    #See https://github.com/twbs/bootstrap/issues/10105 for details, but basically, this callback will only
    #occasionally work. There is a fix commited for Bootstrap 3.1 supposedly
    $("#myModal").on 'shown.bs.modal', ->
      $(".modal-content #new_topic input#topic_space_time_id").val(spaceTimeId)
      $(".modal-content .topic-room").html("Room/Location: " + room)
      $(".modal-content .topic-datetime").html("Time: " + time)
      true

    #Set a callback to destroy all modal data when the modal is hidden. This will prevent the
    #modal from displaying previously entered data when a new modal is opened
    $("#myModal").on 'hide.bs.modal', ->
      $(this).removeData('bs.modal')
      true

    #Show the modal dialog (the new topic form located at /topics/new)
    $("#myModal").modal("show")
    true


  $("#myModal").on("ajax:success", (e, data, status, xhr) ->
    $("#myModal").modal("hide")
    location.reload();
  ).bind "ajax:error", (e, xhr, status, error) ->
      errors = xhr.responseJSON
      errorText = "There were errors with the your topic: <br /><ul>"
      for key, value of errors
          errorText += "<li>" + key + " " + value

      errorText += '</ul>'
      $("#myModal .topic-errors").html errorText
      $("#myModal .topic-errors").show()
      true

  true
