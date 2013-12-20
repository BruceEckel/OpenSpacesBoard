class AddExclusiveSessionNameToSpaceTime < ActiveRecord::Migration
  def change
    add_column :space_times, :exclusive_session_name, :string
  end
end
