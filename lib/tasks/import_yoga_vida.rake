desc "Fetching YogaVida Class schedule"
task :fetch_yogavida_classes => :environment do
  require "capybara"
  require "capybara/dsl"
  require "active_support/all"
  require 'chronic'
  require 'capybara/poltergeist'
  Capybara.run_server = false
  Capybara.javascript_driver = :poltergeist
  Capybara.current_driver = :poltergeist
  Capybara.app_host = "https://clients.mindbodyonline.com"

  module Scraper
    class Yoga
      include Capybara::DSL

    end
  end

  t = Time.now
  t_day = t.strftime('%d')
  t_month = t.strftime('%m')
  t_year = t.strftime('%y')


  spider = Scraper::Yoga.new
  spider.visit('/ASP/home.asp?studioid=8521')
  spider.visit("/ASP/main_class.asp?tg=&vt=&lvl=&stype=-7&view=week&trn=0&page=&catid=&prodid=&date=#{t_month}%2F#{t_day}%2F#{t_year}&classid=0&sSU=&optForwardingLink=&qParam=&justloggedin=&nLgIn=&pMode=")
  puts spider.inspect
  # spider.select("All Location", :from => "optLocation")
  sleep(5)
  schedule = spider.all('table#classSchedule-mainTable tr').map{|row| row}
  # puts schedule.inspect

  day_of_week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    # find the index of all the days
    index_of_day = schedule.map do |row|
      if day_of_week.include?(row.text[0..2])
        schedule.index(row)
      end
    end

  index_of_day.compact!
  # => [0, 9, 21, 31, 45, 53, 62]

  mon_class = schedule[(index_of_day[0]+1)..(index_of_day[1] - 1)]

  hash_schedule = (0..5).inject(Hash.new) do |hash, i|
    hash.merge(schedule[index_of_day[i]].text.to_sym => schedule[(index_of_day[i]+1)..(index_of_day[i+1] - 1)])
  end

  hash_schedule[schedule[index_of_day.last].text.to_sym] = schedule[(index_of_day[6] + 1)..(schedule.count - 1)]

  class_details = []
  puts hash_schedule.inspect

  hash_schedule.each do |class_date, classes|

    classes.each do |class_deets|
      begin
        class_time = "#{class_date.to_s} #{class_deets.find(:xpath, 'td[1]').text}"
        style = class_deets.find(:xpath, 'td[3]').text
        teachers_first_name = class_deets.find(:xpath, 'td[4]').text
        studio = "Yoga Vida #{class_deets.find(:xpath, 'td[5]').text}"
        class_length = class_deets.find(:xpath, 'td[6]').text
        class_time.slice!(0,4)
        puts teachers_first_name
        puts class_time

        next if teachers_first_name.start_with?("Cancelled")

        class_details << {:studio => studio,
                                  :teachers_first_name => teachers_first_name,
                                  :class_date_time=> class_time }
      rescue
        next
      end
    end
  end

  YogaClass.insert_new(class_details)

end
