require_relative 'room_sessions.rb'

describe 'RoomSession' do

  before :each do
    @x = RoomSessions.new(1, 'Session 1', 'PH Downstairs', '9:30', '10:30')
    @y = RoomSessions.new(1, 'Session 2', 'PH Downstairs', '9:55', '10:15')
    @z = RoomSessions.new(1, 'Session 1', 'PH Downstairs', '10:30', '11:30')
  end

  it 'should create correct RoomSession objects' do
    expect(@x.to_s).to eq('(1) 09:30 AM  10:30 AM Session 1 PH Downstairs')
    expect(@y.to_s).to eq('(1) 09:55 AM  10:15 AM Session 2 PH Downstairs')
    expect(@z.to_s).to eq('(1) 10:30 AM  11:30 AM Session 1 PH Downstairs')
  end

  it 'should indicate overlaps' do
    expect(@x.overlaps? @y).to equal(true)
    expect(@y.overlaps? @z).to equal(false)
    expect(@x.overlaps? @z).to equal(false)
  end

end