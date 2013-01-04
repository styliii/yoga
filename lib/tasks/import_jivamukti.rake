desc "Fetching Jivamukti Class schedule"
task :fetch_jivamukti_classes => :environment do
  require 'open-uri'
  require 'nokogiri'
  require 'chronic'

  url = "http://www.jivamuktiyoga.com/events/centers/1466"
  doc = Nokogiri::HTML(open(url))

  raw_info = doc.css('td.calendar-agenda-items')
  dates_of_week = raw_info[0,6].map do |day_of_month|
    day_of_month.text.strip.gsub(/\n/,"")
  end


  raw_info.each_with_index do |td, index|
    # puts index
    next unless td.text.include?(":")
    num_classes = td.css("div.node-title").count

    (0...num_classes).each do |num|
      class_type = td.css("div.node-title")[num].text.strip
      next if td.css("div.node-data-field-class-type-field-class-teacher-uid")[num].nil?

      teacher = td.css("div.node-data-field-class-type-field-class-teacher-uid")[num].text.strip
      teacher_first_name, teacher_last_name = teacher.split(" ")
      class_time = td.css("div.node-data-field-class-datetime-field-class-datetime-value")[num].text.strip
      class_day = dates_of_week[(index + 1) % 7 - 1]
      puts "January #{class_day}"
      puts class_type
      puts "#{teacher_first_name} #{teacher_last_name}"
      puts class_time
      yc1 = YogaClass.create(class_date_time: Chronic.parse("January #{class_day} #{class_time}"))
      yc1.studio = Studio.find_or_create_by_name("Jivamukti")
      yc1.teacher = Teacher.find_or_create_by_first_name(first_name: teacher_first_name, last_name: teacher_last_name)
      yc1.save
    end
  end

end
