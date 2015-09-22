class LibraryMember < User
  has_many :histories
  has_many :books, through: :histories
end
