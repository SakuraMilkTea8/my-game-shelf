class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre
      t.string :developer
      t.string :console
      t.integer :price
      t.datetime :release_date
      t.string :image_url

      t.timestamps
    end
  end
end
