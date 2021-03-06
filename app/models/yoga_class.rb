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

  def self.classes_this_week
    day = DateTime.now
    where("class_date_time >= ? AND class_date_time < ?", day.beginning_of_day, (day + 7.days).end_of_day)
  end

  def self.todays_classes
    self.classes_for_day(Time.now)
  end

  def self.fav_classes_on(day)
    YogaClass.classes_for_day(day).scoped(:joins => :teacher, :conditions => { :teachers => {:favorite => true}})
  end

  def self.fav_classes_this_week
    classes = YogaClass.classes_this_week.scoped(:joins => :teacher, :conditions => { :teachers => {:favorite => true}})
    by_month = classes.order(class_date_time: :asc).group_by{|class_when| class_when.class_date_time.month}
    by_month.each do |month, classes|
      by_month[month] = classes.group_by{|class_when| class_when.class_date_time.day }
    end
  end

  def self.insert_new(details)
    Chronic.time_class = Time.zone
    details.each do |detail|
      begin
        studio_id       = Studio.find_or_create_by(name: detail[:studio]).id
        teacher_id      = Teacher.find_or_create_by_first_name(first_name: detail[:teachers_first_name], last_name: detail[:teachers_last_name]).id
        class_date_time = Chronic.parse(detail[:class_date_time])
        YogaClass.create(studio_id: studio_id, teacher_id: teacher_id, class_date_time: class_date_time )
      rescue Exception => e
        puts "there was an error"
        puts e.inspect
        next
      end
    end
  end

  def visible?
    self.teacher.favorite?
  end
end
