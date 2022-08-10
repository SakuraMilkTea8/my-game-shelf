class AddCategoryToListGame < ActiveRecord::Migration[6.1]
  def change
    add_column :list_games, :category, :string
  end
end
