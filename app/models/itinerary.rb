class Itinerary < ApplicationRecord
	has_many :itinerary_places
	has_many :places, :through => :itinerary_places
end
