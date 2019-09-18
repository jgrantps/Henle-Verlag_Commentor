class AddComposerInitial < ActiveRecord::Migration
  def change
    add_column :composers, :composer_inital, :string
  end
end
