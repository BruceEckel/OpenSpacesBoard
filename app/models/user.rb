class User < ActiveRecord::Base

  has_many :authorizations
  has_many :topics
  validates :name, :email, :presence => true

end
