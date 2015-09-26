class LibraryMember < User
  has_many :histories, dependent: :delete_all
  has_many :books, through: :histories

  validates :email, :uniqueness => true

  def library_member?
    true
  end
end
