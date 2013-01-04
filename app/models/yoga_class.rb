class YogaClass < ActiveRecord::Base
  attr_accessible :class_date_time
  belongs_to :teacher
  belongs_to :studio

  def self.todays_classes
    where("class_date_time >= :start_date AND class_date_time <= :end_date",
    {:start_date => DateTime.now, :end_date => DateTime.now.end_of_day}).order("class_date_time")
  end
end
