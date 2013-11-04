class Recruitment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recruit, :class_name => 'User'
end
