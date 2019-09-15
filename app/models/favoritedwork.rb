class FavoritedWork < ActiveRecord::Base
  has_many :favorites
  has_many :works

end
