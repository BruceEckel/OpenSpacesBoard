class SpaceTime < ActiveRecord::Base
  has_one :topic
  @@locations = [
      'PH Downstairs',
      'PH Stained Glass',
      'PH Piano',
      'Rumors',
      "Bruce's House",
      'Posse House',
      '401 Sopris'
  ]

  def self.rooms
    @@locations
  end

  def to_s
    "rm:#{room} sess:#{session} avail:#{available} excl:#{exclusive_session}"
  end

end
