# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$(document).ready ->
  #Handle clicking on a spacetime block on board/show
  $("td.can-add").click ->
    #Grab the spacetime ID from the board display so we know where the topic should live
    spaceTimeId = $(this).attr("id")
    #Set a callback for once the modal dialog is loaded, and add the spacetime ID to a hidden field
    $("#myModal").on 'shown.bs.modal', ->
      $(".modal-content #new_topic input#topic_space_time_id").val(spaceTimeId)
      true
      #Show the modal dialog (the new topic form located at /topics/new)
    $("#myModal").modal("show")
    true
  true
