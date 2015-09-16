class Book < ActiveRecord::Base
  has_many :histories, dependent: :delete_all
  has_many :library_members, through: :histories

  validates :isbn, :title, :author, :description, presence: true
  validates :isbn, uniqueness: true

  def checked_out?
    return false if histories.take.nil?
    histories.where(return: [nil]).take.nil?
  end
end
