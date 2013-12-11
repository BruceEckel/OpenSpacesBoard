class CreateSpaceTimes < ActiveRecord::Migration
  def change
    create_table :space_times do |t|
      t.string :room
      t.string :sesson
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :available

      t.timestamps
    end
  end
end
