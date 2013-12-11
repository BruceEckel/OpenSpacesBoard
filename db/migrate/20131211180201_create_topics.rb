class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :convener
      t.string :description
      t.string :title
      t.references :space_time, index: true

      t.timestamps
    end
  end
end
