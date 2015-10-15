class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_many :memberships
  has_many :teams, through: :memberships
end
