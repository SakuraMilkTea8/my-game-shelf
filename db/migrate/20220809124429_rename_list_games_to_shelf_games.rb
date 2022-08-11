class RenameListGamesToShelfGames < ActiveRecord::Migration[6.1]
  def change
    rename_table :list_games, :shelf_games
  end
end
