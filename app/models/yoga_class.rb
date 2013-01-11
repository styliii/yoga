class YogaClass < ActiveRecord::Base
  attr_accessible :class_date_time, :studio_id, :teacher_id
  belongs_to :teacher
  belongs_to :studio

  validates :class_date_time, :presence => true, :uniqueness => { :scope => :teacher_id, :message => "duplicate yoga class"}


  def self.classes_for_day(day)
    # note that for this to work in multiple time zones, you should store in UTC and do handle conversions based on time zone of
    # the user viewing a particular page - disregarding for now
    where("class_date_time >= ? AND class_date_time < ?", day.beginning_of_day, day.end_of_day)
  end

  def self.todays_classes
    self.classes_for_day(Time.now)
  end

  def self.todays_fav_classes
    YogaClass.scoped(:joins => :teacher, :conditions => { :teachers => {:favorite => true}}).todays_classes
  end

  def self.insert_new(details)
    details.each do |detail|
      begin
        studio_id       = Studio.find_or_create_by_name(details[:studio]).id
        teacher_id      = Teacher.find_or_create_by_first_name(first_name: details[:teachers_first_name], last_name: details[:teachers_last_name]).id
        class_date_time = Chronic.parse(details[:class_date_time])
        YogaClass.create(studio_id: studio_id, teacher_id: teacher_id, class_date_time: class_date_time )
      rescue
        next
      end
    end
  end

  def visible?
    self.teacher.favorite?
  end
end
