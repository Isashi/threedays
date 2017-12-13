class ItineraryPlace < ApplicationRecord
  belongs_to :itinerary
  belongs_to :place
end
