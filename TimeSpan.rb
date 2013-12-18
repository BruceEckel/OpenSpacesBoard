require 'active_support/all'

class TimeSpan
  attr_accessor :start_time, :duration, :time_range
  def initialize(start_time, duration)
    @start_time = DateTime.parse(start_time)
    @duration = duration
    @time_range = (@start_time..@start_time + @duration - 1.minute) # To keep adjacent hours from overlapping
  end
  def |(other)
    @time_range.overlaps? other.time_range
  end
end

d1 = TimeSpan.new("1-1-2014 10 AM", 1.hour)
d2 = TimeSpan.new("1-1-2014 10:30 AM", 1.hour + 30.minutes)
d3 = TimeSpan.new("1-1-2014 12:00 PM", 1.hour)
p d1 | d2 # true
p d2 | d3 # false