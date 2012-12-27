class YogaClass < ActiveRecord::Base
  attr_accessible :class_date_time
  belongs_to :teacher
  belongs_to :studio
end
