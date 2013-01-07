class YogaClass < ActiveRecord::Base
  attr_accessible :class_date_time, :studio_id, :teacher_id
  belongs_to :teacher
  belongs_to :studio

  validates :class_date_time, :presence => true, :uniqueness => { :scope => :teacher_id, :message => "duplicate yoga class"}

  def self.todays_classes
    where("class_date_time >= :start_date AND class_date_time <= :end_date",
    {:start_date => DateTime.now, :end_date => DateTime.now.end_of_day}).order("class_date_time")
  end

  def self.insert_new(details = {})
    studio_id = Studio.find_or_create_by_name(details[:studio]).id
    teacher_id = Teacher.find_or_create_by_first_name(first_name: details[:teachers_first_name], last_name: details[:teachers_last_name]).id
    class_date_time = Chronic.parse(details[:class_date_time])

    YogaClass.create(studio_id: studio_id, teacher_id: teacher_id, class_date_time: class_date_time )
  end
end
