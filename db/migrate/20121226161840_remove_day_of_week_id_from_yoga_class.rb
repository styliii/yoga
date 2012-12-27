class RemoveDayOfWeekIdFromYogaClass < ActiveRecord::Migration
  def up
    remove_column :yoga_classes, :day_of_week_id
  end

  def down
  end
end
