require_relative 'time_span.rb'

describe 'TimeSpan' do

  before :each do
    @x = TimeSpan.new(1, "10:00", "11:00")
    @y = TimeSpan.new(1, "11:00", "12:00")
    @z = TimeSpan.new(1, "10:30", "11:30")
  end

  it 'should generate correct TimeSpan objects' do
    expect(@x.to_s).to eq('(1) 10:00 AM  11:00 AM')
    expect(@y.to_s).to eq('(1) 11:00 AM  12:00 PM')
    expect(@z.to_s).to eq('(1) 10:30 AM  11:30 AM')
  end

  it 'should indicate overlaps' do
    expect(@x.overlaps? @y).to equal(false)
    expect(@y.overlaps? @z).to equal(true)
    expect(@x.overlaps? @z).to equal(true)
  end

end