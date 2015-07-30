class Event < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :item_urn

  def item
    origin_classname.camelize.constantize.find(origin_id)
  end

  def origin_classname
    item_urn.split(":")[0]
  end

  def origin_id
    item_urn.split(":")[1].to_i
  end
end
