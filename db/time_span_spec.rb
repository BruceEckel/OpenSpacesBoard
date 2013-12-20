require_relative 'time_span.rb'

describe 'TimeSpan_' do

  before :each do
    @x = TimeSpan.new(1, "10:00", "11:00")
    @y = TimeSpan.new(1, "11:00", "12:00")
    @z = TimeSpan.new(1, "10:30", "11:30")
  end

  it 'should generate correct TimeSpan objects' do
    expect(@x.to_s).to eq('(1) 10:00 AM  2014-02-24T10:00:00+00:00..2014-02-24T10:59:00+00:00')
    expect(@y.to_s).to eq('(1) 11:00 AM  2014-02-24T11:00:00+00:00..2014-02-24T11:59:00+00:00')
    expect(@z.to_s).to eq('(1) 10:30 AM  2014-02-24T10:30:00+00:00..2014-02-24T11:29:00+00:00')
  end

  it 'should indicate overlaps' do
    expect(@x.overlaps? @y).to equal(false)
    expect(@y.overlaps? @z).to equal(true)
    expect(@x.overlaps? @z).to equal(true)
  end

end