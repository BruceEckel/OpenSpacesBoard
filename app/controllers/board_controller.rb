class BoardController < ApplicationController
  def show
    @timegroups = SpaceTime.all.group_by(&:start_time)
    @rooms = SpaceTime.rooms
  end

end
