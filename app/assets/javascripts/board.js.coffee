# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$(document).ready ->

  offset = $('.navbar').height();
  $("html:not(.legacy) table").stickyTableHeaders({fixedOffset: offset});

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
    $("#myModal").on 'hidden.bs.modal',  ->
      $(".topic-errors", this).hide()
      $(".modal-content .topic-room").html ""
      $(".modal-content .topic-datetime").html ""
      $("input#topic_title").val ""
      $("textarea#topic_description").val ""
      $(this).off()
      true

    #AJAX callbacks for topic form submission
    $("#myModal").on("ajax:success", (e, data, status, xhr) ->
      #If the form was successfully submitted, simply close the form and refresh the page
      $("#myModal").modal("hide")
      location.reload();
    ).bind "ajax:error", (e, xhr, status, error) ->
      #There were validation errors present, load them up from the JSON response, and
      #display them to the user
      errors = xhr.responseJSON
      errorText = "There were errors with the your topic: <br /><ul>"
      for key, value of errors
          errorText += "<li>" + key + " " + value

      errorText += '</ul>'
      $("#myModal .topic-errors").html errorText
      $("#myModal .topic-errors").show()
      true

    #Show the modal dialog (the new topic form located at /topics/new)
    $("#myModal").modal("show")
    console.log($._data( $('#myModal')[0], "events" ));
    true
  true
