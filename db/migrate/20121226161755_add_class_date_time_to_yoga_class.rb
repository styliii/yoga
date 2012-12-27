class AddClassDateTimeToYogaClass < ActiveRecord::Migration
  def change
    add_column :yoga_classes, :class_date_time, :datetime
  end
end
