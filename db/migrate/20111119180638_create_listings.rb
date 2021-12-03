class CreateListings < ActiveRecord::Migration[4.2]
  def up
    create_table :listings do |t|
      t.string   "name"
      # Properties
      t.text     "description"
      t.text     "location"
      t.datetime "purchase_date" # Item age = today - this
      # Tags
      t.boolean  "elevator_building"
      t.boolean  "pickup_only"

      # Add fields that let Rails automatically keep track
      # of when Listings are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :listings
  end
end
