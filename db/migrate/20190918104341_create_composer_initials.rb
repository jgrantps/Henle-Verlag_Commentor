class CreateComposerInitials < ActiveRecord::Migration
  def change
    create_table :composer_initials do |t|
      t.string :initial
      t.string :url
      t.timestamps null: false
    end
  end
end
