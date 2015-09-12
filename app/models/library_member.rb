class LibraryMember < ActiveRecord::Base
  has_many :histories
  has_many :books, through: :histories
end
