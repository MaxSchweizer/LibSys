class Book < ActiveRecord::Base
  has_many :histories
  has_many :library_members, through: :histories
end
