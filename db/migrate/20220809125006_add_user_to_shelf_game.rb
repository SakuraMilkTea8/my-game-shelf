class AddUserToShelfGame < ActiveRecord::Migration[6.1]
  def change
    add_reference :shelf_games, :user
  end
end
