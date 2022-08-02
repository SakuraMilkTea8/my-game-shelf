class CreateListGames < ActiveRecord::Migration[6.1]
  def change
    create_table :list_games do |t|
      t.references :game, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
