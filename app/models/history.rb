class History < ActiveRecord::Base
  belongs_to :book
  belongs_to :library_member
end
