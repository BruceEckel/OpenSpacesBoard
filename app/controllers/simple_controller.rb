class SimpleController < ApplicationController
  def display
    @spacetimes = SpaceTime.all
  end
end
