module YogaClassesHelper
  def link_to_next_days_classes(description)
    if params[:day]
      date = Chronic.parse("#{params[:month]}/#{params[:day]}/#{params[:year]}").tomorrow
    else
      date = DateTime.now.tomorrow
    end
    link_to description, "/yoga_classes/#{date.strftime("%y")}/#{date.strftime("%m")}/#{date.strftime("%d")}"
  end
end
