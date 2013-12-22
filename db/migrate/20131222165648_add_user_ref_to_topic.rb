class AddUserRefToTopic < ActiveRecord::Migration
  def change
    add_reference :topics, :user, index: true
  end
end
