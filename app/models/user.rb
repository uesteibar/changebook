class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  reverse_geocoded_by :latitude, :longitude, :address => :location
  before_save :reverse_geocode

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


end
