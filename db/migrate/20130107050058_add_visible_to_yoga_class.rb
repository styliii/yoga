class AddVisibleToYogaClass < ActiveRecord::Migration
  def change
    add_column :yoga_classes, :visible, :boolean
  end
end
