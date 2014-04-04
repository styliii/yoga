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
  class ClientMindBody
    include Capybara::DSL
    attr_accessor :schedule, :hash_schedule

    def initialize(studio_id)
      t = Time.now
      t_day = t.strftime('%d')
      t_month = t.strftime('%m')
      t_year = t.strftime('%y')
      visit("/ASP/home.asp?studioid=#{studio_id}")
      visit("/ASP/main_class.asp?tg=&vt=&lvl=&stype=-7&view=week&trn=0&page=&catid=&prodid=&date=#{t_month}%2F#{t_day}%2F#{t_year}&classid=0&sSU=&optForwardingLink=&qParam=&justloggedin=&nLgIn=&pMode=")
      sleep(5)
    end

    def get_schedule
      @schedule = all('table#classSchedule-mainTable tr').map{|row| row}
      @hash_schedule = (0..5).inject(Hash.new) do |hash, i|
        hash.merge(@schedule[index_of_days[i]].text.to_sym => @schedule[(index_of_days[i]+1)..(index_of_days[i+1] - 1)])
      end
      @hash_schedule[@schedule[index_of_days.last].text.to_sym] = @schedule[(index_of_days[6] + 1)..(@schedule.count - 1)]
      @hash_schedule
    end

    def class_details
      class_details = []

      @hash_schedule.each do |class_date, classes|
        puts class_date.inspect

        classes.each do |class_deets|
          next if class_deets.text.start_with?("closed")
          next if class_deets.text.start_with?("Regularly")

          class_time = "#{class_date.to_s} #{class_deets.find(:xpath, 'td[1]').text}"
          style = class_deets.find(:xpath, 'td[3]').text
          teachers_first_name, teachers_last_name = class_deets.find(:xpath, 'td[4]').text.split(" ")
          class_length = class_deets.find(:xpath, 'td[5]').text
          class_time.slice!(0,4)

          next if teachers_first_name.start_with?("Cancelled")

          class_details << {:studio => studio_name,
                            :teachers_first_name => teachers_first_name,
                            :teachers_last_name => teachers_last_name,
                            :class_date_time=> class_time }
        end
      end

      class_details
    end

    private

    def index_of_days
      day_of_week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        # find the index of all the days
        index_of_day = @schedule.map do |row|
          if day_of_week.include?(row.text[0..2])
            @schedule.index(row)
          end
        end
      index_of_day.compact!
    end

    def studio_name
      title.gsub(/ Online/i, "")
    end
  end
end
