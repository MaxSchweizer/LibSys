class LibraryMember < User
  has_many :histories, dependent: :delete_all
  has_many :books, through: :histories

  validates :email, :uniqueness => true

  def library_member?
    true
  end

  def last_checked_out
    histories.where(return: [nil]).take
  end
end
