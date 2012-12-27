desc "Fetching I.AM.YOU Class schedule"
task :fetch_iamyou_classes => :environment do
  require 'open-uri'
  require 'nokogiri'
  require 'chronic'

  url = "http://www.iamyoustudio.com/schedule"
  doc = Nokogiri::HTML(open(url))

  classes_for_the_week = doc.css("ul#class-list div.class-details").map do |yc|
    yc.text.strip.gsub(/\n\t\t/,"").gsub(/\t\t\t/,"")
  end

  weekly_schedule = []

  classes_for_the_week.each do |yc|
    day, date, time, status = yc.split(" ")
    class_schedule = Hash.new
    class_schedule[:date] = date
    class_schedule[:time] = time
    class_schedule[:teacher] = "Lauren"
    class_schedule[:studio] = "iamyoustudio"
    class_schedule[:status] = status

    weekly_schedule << class_schedule
  end

  # puts weekly_schedule.inspect

  weekly_schedule.each do |class_detail|
    unless class_detail[:status] == "No"
      yc1 = YogaClass.create(class_date_time: Chronic.parse(class_detail[:date] + " " + class_detail[:time]).to_datetime)
      yc1.studio = Studio.find_or_create_by_name(class_detail[:studio])
      yc1.teacher = Teacher.find_or_create_by_first_name(first_name: class_detail[:teacher])
      yc1.save
    end
  end
end
