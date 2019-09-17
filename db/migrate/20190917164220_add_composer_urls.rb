class AddComposerUrls < ActiveRecord::Migration
  def change
    add_column :composers, :composer_url, :string
  end
end
