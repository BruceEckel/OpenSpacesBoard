# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery



$(document).ready ->

  # Set the websocket dispather up, with the location based on the current
  dispatcher = new WebSocketRails($('#osboard').data('uri'));

  # Bind the websocket dispatcher to the new_topic event, updating the board
  # everytime a new topic is added by a user
  dispatcher.bind('new_topic', (topic) ->
    # Remove the can-add class, and make the spacetime occupied
    $("td#" + topic.id).removeClass("can-add")
    $("td#" + topic.id).addClass("occupied")
    $("td#" + topic.id).off('click')

    # Add the topic HTML to the spacetime
    $("td#" + topic.id).html(
      '<div class="topic">
        <b>' + topic.title + '</b><br/>' +
        topic.desc + '<br/>
        <small>(' + topic.author + ')</small>
      </div>'
    )
    true
  )

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
    $("#myModal").on 'hidden.bs.modal', ->
      $(".topic-errors", this).hide()
      $(".modal-content .topic-room").html ""
      $(".modal-content .topic-datetime").html ""
      $("input#topic_title").val ""
      $("textarea#topic_description").val ""
      $(this).off()
      true

    #AJAX callbacks for topic form submission
    $("#myModal").on("ajax:success",(e, data, status, xhr) ->
      #If the form was successfully submitted, simply close the form and refresh the page
      $("#myModal").modal("hide")
      dispatcher.trigger('new_topic', {space_time_id: spaceTimeId})
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
    console.log($._data($('#myModal')[0], "events"));
    true
  true

