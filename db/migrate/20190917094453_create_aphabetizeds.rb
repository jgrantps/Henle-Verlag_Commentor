class CreateAphabetizeds < ActiveRecord::Migration
  def change
    create_table :Alphabetizeds do |t|
      t.string :initial
      t.timestamps null: false
    end
  end
end
