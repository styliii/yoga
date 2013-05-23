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
    next if yc.include?("Cancelled")
    day, date, time, status = yc.split(" ")
    class_schedule = Hash.new
    class_schedule[:class_date_time] = date + "/" + Time.now.year.to_s + " " + time
    puts class_schedule[:date_time]
    if yc.include?("LI")
      class_schedule[:teachers_first_name] = "Li"
      class_schedule[:teachers_last_name] = "Ouyang"
    else
      class_schedule[:teachers_first_name] = "Lauren"
      class_schedule[:teachers_last_name] = "Imparato"
    end
    class_schedule[:studio] = "iamyoustudio"
    class_schedule[:status] = status

    weekly_schedule << class_schedule
  end

  weekly_schedule.reject!{|class_detail| class_detail[:status] == "No"}
  YogaClass.insert_new(weekly_schedule)
end
