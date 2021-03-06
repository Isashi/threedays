class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
	    t.string     :image_file_name
	    t.string     :image_content_type
	    t.integer    :image_file_size
	    t.datetime   :image_updated_at
      t.references :place

      t.timestamps
    end
  end
end
