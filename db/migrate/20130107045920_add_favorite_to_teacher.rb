class AddFavoriteToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :favorite, :boolean
  end
end
