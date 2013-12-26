require_relative 'time_span.rb'

class RoomSessions
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

  def self.from_array(init_array)
    # init_array: [Day, Session id, start, end, (location_of_exclusive, exclusive_flag)]
    for sess in init_array
      if sess.last == :exclusive
        excl = RoomSessions.new(sess[0], sess[1], sess[4], sess[2], sess[3])
        excl.exclusive_session = true
        @@sessions << excl
      else
        for loc in SpaceTime.rooms
          @@sessions << RoomSessions.new(sess[0], sess[1], loc, sess[2], sess[3])
        end
      end
    end
  end

  def overlaps?(other)
    (@time_span.overlaps? other.time_span) && (@room == other.room)
  end

  def self.exclude(unavailable_rooms)
    for unav in unavailable_rooms.rooms
      for sess in @@sessions
        if sess.overlaps? unav
          sess.available = false
        end
      end
    end
  end

  def self.sessions
    @@sessions
  end

  def self.rooms
    @@locations
  end

  def to_s
    "#{@time_span} #{@session_id if @available} #{@room} #{'[x]' if not @available}"
  end

  def self.generate_spacetimes
    for s in @@sessions
      SpaceTime.create(room: s.room, session: s.session_id, start_time: s.time_span.start_time, end_time: s.time_span.end_time, available: s.available)
    end
  end

end