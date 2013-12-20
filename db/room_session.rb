require_relative 'time_span.rb'

class RoomSession
  attr_accessor :available, :exclusive_session, :exclusive_session_name, :session_id, :time_span, :room
  def initialize(day, session_id, room, start_time, end_time)
    @session_id = session_id
    @room = room
    @time_span = TimeSpan.new(day, start_time, end_time)
    @available = true
    @exclusive_session = false
    @exclusive_session_name = nil
  end
  def overlaps?(other)
    @time_span.overlaps? other.time_span
  end
  def to_s
    "#{@time_span} #{@session_id} #{@room}"
  end
end