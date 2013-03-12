class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :rentals, :dependent => :destroy
  validates_associated :rentals

  has_many :customers, :dependent => :destroy
  validates_associated :customers

  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  has_many :users, :dependent => :destroy
  validates_associated :users

end
