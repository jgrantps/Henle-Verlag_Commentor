class User < ActiveRecord::Base
  has_secure_password

  has_many :comments
  has_many :favorites

  validates :username, :email, :password, presence: true, on: :create
  validates :email, uniqueness: true, on: :create

  include Concerns::InstanceMethods
  extend Concerns::ClassMethods

end
