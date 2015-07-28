class Book < ActiveRecord::Base
  has_many :ownerships
  has_many :users, through: :ownerships

  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '500x500>'
  }
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\z/

  validates_presence_of :title, :author
end
