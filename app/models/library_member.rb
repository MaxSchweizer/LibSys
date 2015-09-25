class LibraryMember < User
  has_many :histories
  has_many :books, through: :histories

  validates :email, :uniqueness => true

  def library_member?
    true
  end
end
