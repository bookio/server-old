class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_one :session, :dependent => :destroy
  
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations
  
  has_many :rentals, :dependent => :destroy
  validates_associated :rentals

  has_many :customers, :dependent => :destroy
  validates_associated :customers

  has_many :scenes, :dependent => :destroy
  validates_associated :scenes
  
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end