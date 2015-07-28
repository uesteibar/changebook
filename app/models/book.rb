class Book < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :synopsis, :author, :image_url
end
