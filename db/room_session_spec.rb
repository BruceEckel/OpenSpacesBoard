require_relative 'room_session.rb'

describe 'RoomSession' do

  before :each do
    @x = RoomSession.new(1, 'Session 1', 'PH Downstairs', '9:30', '10:30')
    @y = RoomSession.new(1, 'Session 2', 'PH Downstairs', '9:55', '10:15')
    @z = RoomSession.new(1, 'Session 1', 'PH Downstairs', '10:30', '11:30')
  end

  it 'should create correct RoomSession objects' do
    expect(@x.to_s).to eq('(1) 09:30 AM  2014-02-24T09:30:00+00:00..2014-02-24T10:29:00+00:00 Session 1 PH Downstairs')
    expect(@y.to_s).to eq('(1) 09:55 AM  2014-02-24T09:55:00+00:00..2014-02-24T10:14:00+00:00 Session 2 PH Downstairs')
    expect(@z.to_s).to eq('(1) 10:30 AM  2014-02-24T10:30:00+00:00..2014-02-24T11:29:00+00:00 Session 1 PH Downstairs')
  end

  it 'should indicate overlaps' do
    expect(@x.overlaps? @y).to equal(true)
    expect(@y.overlaps? @z).to equal(false)
    expect(@x.overlaps? @z).to equal(false)
  end

end