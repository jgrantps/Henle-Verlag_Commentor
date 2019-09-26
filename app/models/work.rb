class Work < ActiveRecord::Base
  belongs_to :composer
  belongs_to :subcategory
  belongs_to :category

  has_many :comments
  has_many :users, through: :comments

  has_many :favorites

  include Concerns::InstanceMethods
  extend Concerns::ClassMethods
end
