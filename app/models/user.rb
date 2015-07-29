class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

  has_many :ownerships
  has_many :books, through: :ownerships

  has_many :recommendations

  has_many :active_relationships, class_name:  "Following", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Following", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  reverse_geocoded_by :latitude, :longitude, :address => :location
  before_save :reverse_geocode

  validates_presence_of :username
  validates_uniqueness_of :username

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def owns?(book)
    books.include?(book)
  end

  def recommends?(book)
    recommendations.where(book_id: book.id).any?
  end

  def recommend(book, comment)
    recommendations.create(book_id: book.id, comment: comment)
  end

  def offerings
    ownerships.where("to_give_away is true OR to_exchange is true")
  end
  
  def self.search_by_username(term)
    where("username LIKE ?", "%#{term}%")
  end

end
