class LibraryMember < ActiveRecord::Base
  has_many :histories
  has_many :books, through: :histories

  attr_accessor :password_confirmation
  validates_confirmation_of :password
end
