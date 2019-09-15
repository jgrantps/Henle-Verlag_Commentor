class Favorite < ActiveRecord::Base
  belongs_to :user
  has_many :favorite_works
  has_many :works, through: :favorite_works

end
