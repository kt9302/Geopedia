class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :longitude
      t.string :latitude
      t.string :city
      t.string :state
      t.string :country
      t.string :timezone

      t.timestamps
    end
  end
end
