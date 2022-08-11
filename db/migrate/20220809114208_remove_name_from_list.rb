class RemoveNameFromList < ActiveRecord::Migration[6.1]
  def change
    remove_column :lists, :name, :string
  end
end
