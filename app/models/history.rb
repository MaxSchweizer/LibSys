class History < ActiveRecord::Base
  belongs_to :book
  belongs_to :library_member

  def checked_out?
    self.return.nil?
  end
end
