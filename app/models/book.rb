class Book < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :author, :image_url
end
