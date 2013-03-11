class Scene < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :name
  serialize :content
end


