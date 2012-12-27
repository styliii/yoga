class Studio < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :yoga_classes
end
