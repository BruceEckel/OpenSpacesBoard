class SimpleController < ApplicationController
  def display
    @spacetimes = SpaceTime.order("start_time")
    @rooms = SpaceTime.rooms
  end
end
