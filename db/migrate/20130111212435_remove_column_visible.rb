class RemoveColumnVisible < ActiveRecord::Migration
  def up
    remove_column :yoga_classes, :visible
  end

  def down
    add_column :yoga_classes, :visible, :boolean
  end
end
