class Book < ActiveRecord::Base
  has_many :ownerships
  has_many :users, through: :ownerships

  has_many :recommendations

  belongs_to :genre

  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '500x500>'
  }
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\z/

  validates_presence_of :title, :author

  after_commit :index_elasticsearch
  before_destroy :destroy_elasticsearch

  def self.search_by_title(title)
    where("UPPER(title) LIKE ?", "%#{title.upcase}%")
  end

  def self.search_offered_by_title(title)
    joins(:ownerships).where("UPPER(title) LIKE ?", "%#{title.upcase}%").where("ownerships.to_give_away is true OR ownerships.to_exchange is true")
  end

  def offerings
    ownerships.where("to_give_away is true OR to_exchange is true")
  end

  def offerings_count
    ownerships.where("to_give_away is true OR to_exchange is true").count
  end

  def valoration
    recommendations.inject(0) do |amount, recommendation|
      amount + (recommendation.valoration * (recommendation.user.reputation.to_f / 1000))
    end
  end

  private

  def index_elasticsearch
    BooksElasticsearch.new.index(self)
  end

  def destroy_elasticsearch
    BooksElasticsearch.new.destroy(self)
  end

end
