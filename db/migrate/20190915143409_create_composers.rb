class CreateComposers < ActiveRecord::Migration
  def change
    create_table :composers do |t|
      t.string :name
    end
  end
end
