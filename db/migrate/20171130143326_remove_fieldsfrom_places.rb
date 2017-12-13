class RemoveFieldsfromPlaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :image_file_name,    :string
    remove_column :places, :image_content_type, :string
    remove_column :places, :image_file_size,    :integer
    remove_column :places, :image_updated_at,   :datetime  	
  end
end
