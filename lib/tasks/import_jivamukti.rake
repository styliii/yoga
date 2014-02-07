desc "Fetching Jivamukti Class schedule"
task :fetch_jivamukti_classes => :environment do
  require 'open-uri'
  require 'nokogiri'
  require 'chronic'

  url = "http://www.jivamuktiyoga.com/events/centers/1466"
  doc = Nokogiri::HTML(open(url))
  raw_info = doc.css('td.calendar-agenda-items')
  dates_of_week = raw_info[0,6].map do |day_of_month|
    day_of_month.text.strip.gsub(/\n/,"").split.first
  end

  class_details = []

  raw_info.each_with_index do |td, index|
    # puts index
    next unless td.text.include?(":")
    num_classes = td.css("div.node-title").count

    (0...num_classes).each do |num|
      class_type = td.css("div.node-title")[num].text.strip
      next if td.css("div.view-data-customfield-phpcode-3")[num].nil?

      teacher = td.css("div.view-data-customfield-phpcode-3")[num].text.strip
      teachers_first_name, teachers_last_name = teacher.split(" ")
      class_time = td.css("div.node-data-field-class-datetime-field-class-datetime-value")[num].text.strip
      class_month = DateTime.now.strftime("%B")
      class_day = dates_of_week[(index + 1) % 7 - 1].gsub(/\s+/, "")
      puts "#{teachers_first_name} #{teachers_last_name}"
      class_date_time = "#{class_month} #{class_day[0..-2]}, #{class_time}"
      studio = "Jivamukti"

      class_details <<  {:studio => studio,
               :teachers_first_name => teachers_first_name,
               :teachers_last_name => teachers_last_name,
               :class_date_time => class_date_time}
    end
  end

  YogaClass.insert_new(class_details)
end


