class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :long, {:precision=>10, :scale=>6}

      t.timestamps
    end
    add_index :places, [:user_id, :created_at]
  end
end
