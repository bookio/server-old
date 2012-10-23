class Session < ActiveRecord::Base
  belongs_to :user
  before_save :generate_sid
  
  def generate_sid
    self.sid = rand(36**32).to_s(36)
  end
end
