require 'rspec'
require_relative 'time_span.rb'

describe 'TimeSpan_' do

  before :each do
    @x = TimeSpan.new(1, "10:00", "11:00")
    @y = TimeSpan.new(1, "11:00", "12:00")
    @z = TimeSpan.new(1, "10:30", "11:30")
  end

  it 'should generate correct TimeSpan objects' do
    @x.to_s == 'TimeSpan(1, "10:00", "11:00")'
    @y.to_s == ""
    @z.to_s == ""
  end
end