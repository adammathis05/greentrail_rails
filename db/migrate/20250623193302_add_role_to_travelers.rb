class AddRoleToTravelers < ActiveRecord::Migration[7.2]
  def change
    add_column :travelers, :role, :string, default: "traveler", null: false
  end
end
