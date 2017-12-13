class CreateItineraryPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :itinerary_places do |t|
      t.belongs_to :itinerary, index: true
      t.belongs_to :place, index: true
      t.timestamps
    end
  end
end
