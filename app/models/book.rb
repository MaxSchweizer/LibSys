class Book < ActiveRecord::Base
  has_many :histories
  has_many :library_members, through: :histories

  def checked_out?
    histories.each do |history|
      if history.return.nil?
        return true
      end
    end
    false
  end
end
