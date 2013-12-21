require_relative 'time_span.rb'

class RoomSession
  @@sessions = []
  attr_accessor :available, :exclusive_session, :exclusive_session_name, :session_id, :time_span, :room

  def initialize(day, session_id, room, start_time, end_time)
    @session_id = session_id
    @room = room
    @time_span = TimeSpan.new(day, start_time, end_time)
    @available = true
    @exclusive_session = false
    @exclusive_session_name = nil
  end

  def self.from_array(init_array, locations)
    # init_array: [Day, Session id, start, end, (location_of_exclusive, exclusive_flag)]
    # locations: array of room names
    for sess in init_array
      if sess.last == :exclusive
        excl = RoomSession.new(sess[0], sess[1], sess[4], sess[2], sess[3])
        excl.exclusive_session = true
        @@sessions << excl
      else
        for loc in locations
          @@sessions << RoomSession.new(sess[0], sess[1], loc, sess[2], sess[3])
        end
      end
    end
  end

  def self.sessions
    @@sessions
  end

  def overlaps?(other)
    @time_span.overlaps? other.time_span
  end

  def to_s
    "#{@time_span} #{@session_id} #{@room}"
  end

end