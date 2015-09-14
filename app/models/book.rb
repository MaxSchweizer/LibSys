class Book < ActiveRecord::Base
  has_many :histories
  has_many :library_members, through: :histories

  validates :isbn, :title, :author, :description, presence: true
  validates :isbn, uniqueness: true

  def checked_out?
    histories.where(return: [nil]).take.nil?
  end
end
