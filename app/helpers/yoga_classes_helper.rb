module YogaClassesHelper
  def link_to_next_days_classes(description)
    if params[:day]
      date = Chronic.parse("#{params[:month]}/#{params[:day]}/#{params[:year]}").tomorrow
    else
      date = DateTime.now.tomorrow
    end
    link_to description, "/yoga_classes/#{date.strftime("%y")}/#{date.strftime("%m")}/#{date.strftime("%d")}"
  end

  def link_to_google_calendar(yoga_class)
    yoga_class_details = {
      title: gcal_title(yoga_class),
      location: gcal_location(yoga_class),
      start_date_time: gcal_start_date_time(yoga_class),
      end_date_time: gcal_end_date_time(yoga_class)
    }

    yoga_class_details.each do |k, v|
      yoga_class_details[k] = URI.encode(v)
    end

    "<a href='http://www.google.com/calendar/event?action=TEMPLATE&text=#{yoga_class_details[:title]}&dates=#{yoga_class_details[:start_date_time]}/#{yoga_class_details[:end_date_time]}&details=Review%20of%20Li%20here&location=#{yoga_class_details[:location]}&trp=true&sprop=Yoga%20In%20the%20City&sprop=name:www.test.com' target='_blank'>Add to Calendar</a>"
  end

  def gcal_title(yoga_class)
    "Yoga with #{yoga_class.teacher.first_name} at #{yoga_class.studio.name}"
  end

  def gcal_location(yoga_class)
    yoga_class.studio.location
  end

  def gcal_start_date_time(yoga_class)
    yc_date_time = yoga_class.class_date_time
    yc_date = yc_date_time.strftime("%Y%m%d")
    yc_time = yc_date_time.strftime("%H%M%S")
    "#{yc_date}T#{yc_time}Z"
  end

  def gcal_end_date_time(yoga_class)
    yc_date_time = yoga_class.class_date_time + 1.hour
    yc_date = yc_date_time.strftime("%Y%m%d")
    yc_time = yc_date_time.strftime("%H%M%S")
    "#{yc_date}T#{yc_time}"
  end
end
