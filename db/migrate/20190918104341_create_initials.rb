class CreateInitials < ActiveRecord::Migration
  def change
    create_table :initials do |t|
      t.string :initial
      t.string :url
      t.timestamps null: false
    end
  end
end
