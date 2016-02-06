class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|
      t.text :name
      t.integer :founded
      t.text :city

      t.timestamps null: false
    end
  end
end
