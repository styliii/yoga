class Teacher < ActiveRecord::Base
  attr_accessible :first_name, :last_name
  has_many :yoga_classes

  validates :first_name, presence: true
  # validates :full_name, :uniqueness => true

  # def full_name
  #   "#{first_name} #{last_name}"
  # end
end
