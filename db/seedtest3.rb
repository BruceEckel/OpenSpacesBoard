require_relative 'time_span'
require_relative 'room_sessions'

locations = [
    'PH Downstairs',
    'PH Stained Glass',
    'PH Piano',
    'Rumors',
    "Bruce's House",
    'Posse House',
]

sessions = [
    # Day, Session id, start, end, (location_of_exclusive, exclusive_flag)
    [ 1, 'Session 1', '9:30', '10:30' ],
    [ 1, 'Session 2', '11:00', '12:00' ],
    [ 1, 'Workshop 1', '2:00 PM', '5:30 PM' ],
    [ 1, 'Lightning Talks', '7:30 PM', '9:00 PM', 'PH Stained Glass', :exclusive],
    [ 2, 'Session 3', '8:30', '9:30' ],
    [ 2, 'Session 4', '10:00', '11:00' ],
    [ 2, 'Session 5', '11:30', '12:30' ],
    [ 2, 'Workshop 2', '2:00 PM', '5:30 PM' ],
    [ 2, 'Lightning Talks', '7:30 PM', '9:00 PM', 'PH Stained Glass', :exclusive],
    [ 3, 'Hackathon', '9:00', '5:30 PM' ],
    [ 3, 'Hackathon Showcase Lightning Talks', '7:30 PM', '9:00 PM', 'PH Stained Glass', :exclusive],
    [ 3, 'Pub Discussions', '9:00 PM', '12:00 PM', 'Town Pubs', :exclusive],
    [ 4, 'Session 6', '8:30', '9:30' ],
    [ 4, 'Session 7', '10:00', '11:00' ],
    [ 4, 'Session 8', '11:30', '12:30' ],
    [ 4, 'Workshop 3', '2:00 PM', '5:30 PM' ],
    [ 4, 'Progressive Dinner', '5:30 PM', '8:00 PM', 'Rental Houses', :exclusive],
    [ 4, 'Live JavaPosse recording and Conference Feedback', '8:00 PM', '9:30 PM', 'PH Downstairs', :exclusive],
    [ 4, 'Pub Discussions', '9:30 PM', '12:00 PM', 'Town Pubs', :exclusive],
    [ 5, 'Session 9', '8:30', '9:30' ],
    [ 5, 'Session 10', '10:00', '11:00' ],
    [ 5, 'Session 11', '11:30', '12:30' ],
    [ 5, 'Workshop 4', '2:00 PM', '5:30 PM' ],
    [ 5, "Dinner", '6:00 PM', '9:00 PM', "Django's or Yurt", :exclusive],
    [ 6, 'Breakfast', '8:30', '1:00 PM', "Bruce's House", :exclusive],
]

unavailable = [
    # Room                 day   start       end
    ['PH Downstairs',       1, '3:45 PM', '6:00 PM'], # Hebrew
    ['PH Downstairs',       3, '3:30 PM', '7:00 PM'], # Religious education
    ['PH Stained Glass',    3, '3:30 PM', '7:00 PM'], # Religious education
    ['PH Piano',            3, '3:30 PM', '7:00 PM'], # Religious education
    ['PH Downstairs',       2, '5:00 PM', '9:00 PM'], # Prayer Group/Bible Class
    ['PH Downstairs',       5, '7:00 AM', '9:00 AM'], # Men's Group
]

class UnavailableRooms # Move this to its own file
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

RoomSessions.from_array(sessions, locations)
UnavailableRooms.from_array(unavailable)

RoomSessions.exclude(UnavailableRooms)
RoomSessions.sessions.each { |s| p s}
UnavailableRooms.rooms.each { |r| p r }


# Need Function that takes a RoomSession and turns it into a SpaceTime
# Method of Room Session?

