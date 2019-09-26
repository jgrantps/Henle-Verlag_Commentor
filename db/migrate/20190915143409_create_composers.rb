class CreateComposers < ActiveRecord::Migration
  def change
    create_table :composers do |t|
      t.string :name
      t.string :url
      t.integer :initial_id
      t.timestamps null: false

    end
  end
end
