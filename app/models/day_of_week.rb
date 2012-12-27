class DayOfWeek < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :weekday
  has_many :yoga_classes
end
