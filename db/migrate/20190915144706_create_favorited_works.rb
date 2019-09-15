class CreateFavoritedWorks < ActiveRecord::Migration
  def change
    t.integer :favorite_id
    t.integer :work_id
  end
end
