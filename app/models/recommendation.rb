class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :user_id, :book_id, :comment
end
