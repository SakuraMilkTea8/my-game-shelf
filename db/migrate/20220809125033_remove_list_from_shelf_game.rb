class RemoveListFromShelfGame < ActiveRecord::Migration[6.1]
  def change
    remove_reference :shelf_games, :list
  end
end
