require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :name, :client_id
  attr_accessor :password

  validates_presence_of :username
  validates_uniqueness_of :username

  has_one :session, :dependent => :destroy
  
  belongs_to :client
  
  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

end