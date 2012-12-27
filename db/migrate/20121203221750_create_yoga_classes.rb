class CreateYogaClasses < ActiveRecord::Migration
  def change
    create_table :yoga_classes do |t|
      t.integer :studio_id
      t.integer :teacher_id
      t.integer :day_of_week_id
      t.timestamps
    end
  end
end
