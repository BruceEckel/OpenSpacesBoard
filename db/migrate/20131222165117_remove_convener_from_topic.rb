class RemoveConvenerFromTopic < ActiveRecord::Migration
  def change
    remove_column :topics, :convener, :string
  end
end
