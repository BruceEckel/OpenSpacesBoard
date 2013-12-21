class SimpleController < ApplicationController
  def display
    @spacetimes = SpaceTime.order("start_time")
  end
end
