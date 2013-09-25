class Setting < ActiveRecord::Base
  attr_accessible :client_id, :name, :section, :value
  
  belongs_to :client
  serialize :value

end
