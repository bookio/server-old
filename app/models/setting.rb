class Setting < ActiveRecord::Base
  attr_accessible :group_id, :name, :section, :value
  
  belongs_to :group
  serialize :value

end
