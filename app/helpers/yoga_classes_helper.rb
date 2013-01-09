module YogaClassesHelper
  def link_to_tomorrows_classes(description)
    date = DateTime.now.tomorrow
    link_to description, "yoga_classes/#{date.strftime("%y")}/#{date.strftime("%m")}/#{date.strftime("%d")}"
  end
end
