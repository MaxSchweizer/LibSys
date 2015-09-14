class LibraryMember < ActiveRecord::Base
  has_many :histories
  has_many :books, through: :histories

  has_secure_password

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: {with: VALID_EMAIL_REGEX}
end
