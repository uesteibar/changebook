class Book < ActiveRecord::Base
  belongs_to :user

  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\z/

  validates_presence_of :title, :author
end
