class RemoveEclusiveSessionNameFromSpaceTime < ActiveRecord::Migration
  def change
    remove_column :space_times, :exclusive_session_name, :string
  end
end
