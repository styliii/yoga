class Teacher < ActiveRecord::Base
  attr_accessible :first_name
  has_many :yoga_classes
end
