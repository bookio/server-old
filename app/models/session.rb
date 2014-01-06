class Session < ActiveRecord::Base
  belongs_to :user
  before_save :generate_sid

  def generate_sid
    self.sid = SecureRandom.uuid()
  end

  def self.find_by_user user
    self.find_by_user_id(user.id)
  end
end
