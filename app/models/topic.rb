class Topic < ActiveRecord::Base
  belongs_to :space_time
  belongs_to :user
end
