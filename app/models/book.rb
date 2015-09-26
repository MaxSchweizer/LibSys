class Book < ActiveRecord::Base
  has_many :histories, dependent: :delete_all
  has_many :library_members, through: :histories

  validates :isbn, :title, :authors, :description, presence: true
  validates :isbn, uniqueness: true

  def checked_out?
    return false if histories.take.nil?
    !last_checked_out.nil?
  end

  def checked_out_to?
    last_checked_out.library_member unless last_checked_out.nil?
  end

  def my_history(user)
    histories.where("library_member_id = ?", user.id)
  end

  private
  def last_checked_out
    histories.where(return: [nil]).take
  end
end
