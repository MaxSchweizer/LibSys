class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  def admin?
    false
  end

  def library_member?
    false
  end
end
