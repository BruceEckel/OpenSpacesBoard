class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :space_times, :sesson, :session
  end
end
