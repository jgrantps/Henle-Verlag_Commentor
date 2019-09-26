class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :works, through: :subcategories
  has_many :composers, through: :works

end
