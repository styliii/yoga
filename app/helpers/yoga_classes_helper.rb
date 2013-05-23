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
    # "http://www.google.com/calendar/event?action=TEMPLATE&text=Yoga%20Class%20with%20Li&dates=20130529T230000Z/20130530T000000Z&details=&location=132%20Mulberry%20St%2C%20I.AM.YOU%20Studio&trp=true&sprop=Yoga%20in%20the%20City&sprop=name:http%3A%2F%2Fyogainthecity.herokuapp.com%2F"
    # http://www.google.com/calendar/event?action=TEMPLATE&
    # text=Yoga%20Class%20with%20Li&
    # dates=20130529T230000Z/20130530T000000Z&
    # details=&
    #   location=132%20Mulberry%20St%2C%20I.AM.YOU%20Studio&
    #   trp=true&
    #   sprop=Yoga%20in%20the%20City&
    #   sprop=name:http%3A%2F%2Fyogainthecity.herokuapp.com%2F
    # {
    #   :title => "Yoga Class with #{yoga_class.teacher.first_name}",
    #   :dates => ,

    # }
  end
end
