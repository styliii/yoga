class Teacher < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :specialty_list, :favorite
  has_many :yoga_classes
  acts_as_taggable_on :specialty

  validates :first_name, presence: true
  # validates :full_name, :uniqueness => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.favorite_teachers
    Teacher.all.collect{|teacher| teacher if teacher.favorite}.compact
  end
end
