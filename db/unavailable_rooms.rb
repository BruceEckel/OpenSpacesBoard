class UnavailableRooms
  @@rooms = []
  attr_accessor :room, :day, :start_time, :end_time, :time_span

  def initialize(room, day, start_time, end_time)
    @room, @day, @start_time, @end_time = room, day, start_time, end_time
    @time_span = TimeSpan.new(day, start_time, end_time)
  end

  def self.from_array(blackouts)
    blackouts.each do |room, day, start, _end|
      @@rooms << UnavailableRooms.new(room, day, start, _end)
    end
  end

  def self.rooms
    @@rooms
  end

  def to_s
    "#{@day} #{@room} #{@start_time} #{@end_time}"
  end

end