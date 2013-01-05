class Dropdaysofweek < ActiveRecord::Migration
  def up
    drop_table :day_of_weeks
  end

  def down
  end
end
