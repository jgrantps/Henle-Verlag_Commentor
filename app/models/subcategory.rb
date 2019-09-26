class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :works
  has_many :composers, through: :works
end
