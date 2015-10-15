class Membership < ActiveRecord::Base
  validates_presence_of :user_id, :team_id
  validates_uniqueness_of :user_id, scope: :team_id
end
