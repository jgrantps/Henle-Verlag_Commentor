class Favorite < ActiveRecord::Base
  belongs_to :user
  has_many :favorited_works
  has_many :works, through: :favorited_works

end
