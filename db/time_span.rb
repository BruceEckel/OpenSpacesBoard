require 'active_support/all'

class TimeSpan
  @@start_day = '2014-2-24'
  attr_accessor :day, :start_time, :end_time, :time_range, :start_day

  def initialize(day, start_time, end_time)
    @day = day
    @start_time = DateTime.parse(@@start_day + ' ' + start_time) + (@day - 1)
    @end_time = DateTime.parse(@@start_day + ' ' + end_time) + (@day - 1)
    @time_range = @start_time..(@end_time - 1.minute) # To keep adjacent hours from overlapping
  end

  def overlaps?(other)
    @time_range.overlaps? other.time_range
  end

  def to_s
    "D#{@day} #{@start_time.strftime("%I:%M%p")}-#{@end_time.strftime("%I:%M%p")}"
  end
end