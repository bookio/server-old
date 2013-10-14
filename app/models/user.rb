class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :name, :client_id
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_presence_of :username
  validates_uniqueness_of :username

  has_one :session, :dependent => :destroy
  
  belongs_to :client
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end