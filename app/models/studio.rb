class Studio < ActiveRecord::Base
  attr_accessible :name, :location
  has_many :yoga_classes
end
