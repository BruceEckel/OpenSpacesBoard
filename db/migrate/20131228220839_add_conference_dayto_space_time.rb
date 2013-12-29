class AddConferenceDaytoSpaceTime < ActiveRecord::Migration
  def change
    add_column :space_times, :conference_day, :integer
  end
end
