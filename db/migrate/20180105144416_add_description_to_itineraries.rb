class AddDescriptionToItineraries < ActiveRecord::Migration[5.1]
  def change
    add_column :itineraries, :description, :text
  end
end
