class Composer < ActiveRecord::Base
  has_many :works
  has_many :subcategories, through: :works
  has_many :categories, through: :subcategories
  has_many :favorited_works, through: :works
  has_many :favorites, through: :favorited_works
  has_many :users, through: :favorites

end
