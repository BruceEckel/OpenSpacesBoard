require_relative 'time_span.rb'

class RoomSessions
  @@sessions = []
  attr_accessor :available, :exclusive_session, :session_id, :time_span, :room, :day

  def initialize(day, session_id, room, start_time, end_time, exclusive_session = false)
    @day = day
    @session_id = session_id # Doubles as exclusive session name
    @room = room
    @time_span = TimeSpan.new(day, start_time, end_time)
    @available = true
    @exclusive_session = exclusive_session
  end

  def self.from_array(init_array)
    # init_array: [Day, Session id, start, end, (location_of_exclusive, exclusive_flag)]
    for sess in init_array
      if sess.last == :exclusive
                                      # day, session_id, room, start_time, end_time, exclusive_session
        @@sessions << RoomSessions.new(sess[0], sess[1], sess[4], sess[2], sess[3], true)
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
      SpaceTime.create(conference_day: s.day,
                       room: s.room,
                       session: s.session_id,
                       start_time: s.time_span.start_time,
                       end_time: s.time_span.end_time,
                       available: s.available,
                       exclusive_session: s.exclusive_session)
    end
  end

end