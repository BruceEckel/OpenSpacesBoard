class AddExclusiveSessionToSpaceTime < ActiveRecord::Migration
  def change
    add_column :space_times, :exclusive_session, :boolean
  end
end
