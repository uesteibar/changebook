class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  reverse_geocoded_by :latitude, :longitude, :address => :location
  before_save :reverse_geocode

  validates_presence_of :username
  validates_uniqueness_of :username

end
