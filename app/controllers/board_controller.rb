class BoardController < ApplicationController

  helper_method :find_space_time_topic

  def show
    @timegroups = SpaceTime.all.group_by(&:start_time)
    @rooms = SpaceTime.rooms
  end

  private

  def find_space_time_topic(space_time_id)
    Topic.find_by space_time_id: space_time_id
  end

end
