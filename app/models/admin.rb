class Admin < User

  validates :email, :uniqueness => true

  def admin?
    true
  end
end
