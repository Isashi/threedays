class Place < ApplicationRecord
	before_save { |place| place.title = place.title.capitalize }

  default_scope -> {order(title: :asc)}

  belongs_to :user
  has_many :comments
  
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :lat, :long, presence: true
  validates_numericality_of :lat, :long, :message=>'Please input a number'

  has_many :pictures, :dependent => :destroy

  has_many :itinerary_places
  has_many :itinerarys, through: :itinerary_places

end
