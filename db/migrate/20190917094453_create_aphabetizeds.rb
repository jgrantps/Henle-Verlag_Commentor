class CreateAphabetizeds < ActiveRecord::Migration
  def change
    create_table :Alphabetized do |t|
      t.string :initial
      t.timestamps null: false
    end
  end
end
