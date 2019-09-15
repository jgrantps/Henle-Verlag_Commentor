class CreateFavoritedWorks < ActiveRecord::Migration
  def change
    create_table :favorited_works do |t|
      t.integer :favorite_id
      t.integer :work_id
    end
  end
end
