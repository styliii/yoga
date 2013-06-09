require 'spec_helper'
require 'chronic'

describe YogaClassesHelper do
  before do
    @teacher = Teacher.create(first_name: "Li")
    @studio = Studio.create(name: "I.AM.YOU. Studio", location: "132 Mulberry Street")
    @yoga_class = YogaClass.create(teacher_id: @teacher.id, class_date_time: Chronic.parse("Wednesday 7pm"), studio_id: @studio.id)
  end

  it "creates a link that adds a google calendar event" do
    link_to_google_calendar(@yoga_class).should eq("<a href='http://www.google.com/calendar/event?action=TEMPLATE&text=Yoga%20with%20Li%20at%20I.AM.YOU.%20Studio&dates=20130612T190000Z/20130612T200000Z&details=Review%20of%20Li%20here&location=132%20Mulberry%20Street&trp=true&sprop=Yoga%20In%20the%20City&sprop=name:www.test.com' target='_blank'>Add to Calendar</a>")
  end

  it "creates a google calendar event title" do
    gcal_title(@yoga_class).should eq("Yoga with Li at I.AM.YOU. Studio")
  end

  it "creates a google calendar event location" do
    gcal_location(@yoga_class).should eq("132 Mulberry Street")
  end
  
  it "creates a google calendar start event time" do
    gcal_start_date_time(@yoga_class).should eq("20130612T190000Z")
  end

  it "creates a google calendar end event time" do
    gcal_end_date_time(@yoga_class).should eq("20130612T200000Z")
  end
end
