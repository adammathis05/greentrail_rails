class UpdateTravelersNameFields < ActiveRecord::Migration[7.1]
  def change
    add_column :travelers, :first, :string
    add_column :travelers, :last, :string
    remove_column :travelers, :name, :string
  end
end
