class Session < ActiveRecord::Base
  belongs_to :user
  before_save :generate_sid
  
  def generate_sid
    self.sid = SecureRandom.uuid()
  end
end
