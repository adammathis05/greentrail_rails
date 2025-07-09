class AddDefaultRoleToTravelers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :travelers, :role, from: nil, to: 'traveler'
  end
end
