$ = jQuery

$(document).ready ->

  board = (() ->

    dispatcher = new WebSocketRails('wss://evening-harbor-6170.herokuapp.com/websocket')
    validSpaceTimes = $("td.can-add")
    modal = $("#topicModal")
    modalContent = $(".modal-content", modal)

    ###
    Bind all of the relevant events to the websockets dispatcher
    These include:
    - new_topic - triggered when a new topic is added to the DB
    - lock_spacetime - triggered when a user selects a spacetime to edit
    - unlock_spacetime - triggered when a user closes a topic modal window
    ###
    bindEvents = () ->
      dispatcher.bind 'new_topic', (topic) ->
        addTopic(topic)
        true
      dispatcher.bind 'lock_spacetime', (topic) ->
        lockCell(topic)
        true
      dispatcher.bind 'unlock_spacetime', (topic) ->
        unlockCell(topic)
        true
      true

    ###
    Triggered upon the addition of a new topic. Adds a new topic 
    to the assigned spacetime
    ###
    addTopic = (topic) ->
      topicCell = $("td#" + topic.id)
      topicCell.removeClass("can-add")
      topicCell.addClass("occupied")
      topicCell.off('click')
      topicCell.html(
          '<div class="topic">
            <b>' + topic.title + '</b><br/>' +
            topic.desc + '<br/>
            <small>(' + topic.author + ')</small>
          </div>'
      )
      true

    ###
    Locks a cell from further editing. This is triggered when a user
    begins interacting with an open spacetime (read: opens a modal to 
    create a new/edit a topic)
    ###
    lockCell = (topic) ->
      topicCell = $("td#" + topic.id)
      topicCell.removeClass("can-add")
      topicCell.addClass("locked")
      topicCell.off('click')
      true

    ###
    Unlock a spacetime, so it may be edited or used again. If a topic
    was created in the spacetime, it is not unlocked
    ###
    unlockCell = (topic) ->
      topicCell = $("td#" + topic.id)
      topicCell.removeClass("locked")
      if topicCell.hasClass('occupied') == false
        topicCell.addClass('can-add')
        topicCell.on('click', bindSpaceTimeClick)
      true

    ###
    Binds a click event to a spacetime. Upon clicking a spacetime, a
    bootstrap modal is opened, pointing to the topic creation form.
    ###
    bindSpaceTimeClick = (e) ->
      $this = $(this)
      spaceTimeId = $this.attr('id')
      room = $this.data('room')
      time = $this.data('time')
      modal.on 'shown.bs.modal', () ->
        updateModal spaceTimeId, room, time
        true
      modal.on 'hidden.bs.modal', () ->
        destroyModal spaceTimeId, $this
        true
      modal.on 'ajax:success', (e, data, status, xhr) ->
        newTopicSuccess(e, data, status, xhr, spaceTimeId)
        true
      .bind 'ajax:error', (e, xhr, status, error) ->
        newTopicFailure(e, xhr, status, error)
        true
      modal.modal 'show'
      true

    ###
    Once a modal is fully loaded, add some additional data into it, 
    such as the spacetime ID, time and room. This is also when the lock
    is triggered.
    ###
    updateModal = (spaceTimeId, room, time) ->
      dispatcher.trigger 'lock_spacetime', {space_time_id: spaceTimeId}
      $('#new_topic input#topic_space_time_id').val spaceTimeId
      $('.topic-room').html 'Room/Location: ' + room
      $('.topic-datetime').html 'Time: ' + time
      true

    ###
    When a modal is a closed, reset the state of the modal, and also 
    unlock the spacetime the modal was invoked from
    ###
    destroyModal = (spaceTimeId, $this) ->
      dispatcher.trigger 'unlock_spacetime', {space_time_id: spaceTimeId}
      $('.topic-errors').hide()
      $('.topic-room').html ''
      $('.topic-datetime').html ''
      $('input#topic_title').val ''
      $('textarea#topic_description').val ''
      $this.off()
      true

    ###
    Success callback, used when creating a new topic. Unlocks the spacetime
    it was invoked from, and triggers the new_topic event, which will update 
    the board for all connected clients
    ###
    newTopicSuccess = (e, data, status, xhr, spaceTimeId) ->
      modal.modal 'hide'
      dispatcher.trigger 'unlock_spacetime', {space_time_id: spaceTimeId}
      dispatcher.trigger 'new_topic', {space_time_id: spaceTimeId}
      true

    ###
    Failure callback, used when creating a new topic. Prints any errors returned
    to the modal
    ###
    newTopicFailure = (e, xhr, status, error) ->
      errors = xhr.responseJSON
      errorText = 'There were errors with your topic: <br /><ul>'
      for key, value of errors
        errorText += '<li>' + key + ' ' + value

      errorText += '</ul>'
      $('.topic-errors').html errorText
      $('.topic-errors').show()
      true

    # Bind all valid (non-occupied) spacetimes with the click handler
    validSpaceTimes.click bindSpaceTimeClick

    # Make our bindEvents method publically available
    return bindEvents : bindEvents

    )()

  # Set up Sticky headers on the board layout table
  offset = $('.navbar').height();
  $("html:not(.legacy) table").stickyTableHeaders({fixedOffset: offset});

  # Bind all relevant events to the websockets dispatcher
  board.bindEvents()
    
  true

