class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.string :image_url
      t.string :link_url
      t.integer :composer_id
      t.integer :subcategory_id
    end
  end
end
