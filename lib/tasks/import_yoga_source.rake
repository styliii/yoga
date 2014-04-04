desc "Fetching Yoga Source Class schedule"
task :fetch_yoga_source_classes => :environment do
  spider = Scraper::ClientMindBody.new(25)
  spider.get_schedule
  class_details = spider.class_details
  YogaClass.insert_new(class_details)
end
