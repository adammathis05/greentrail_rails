class AddForeignKeysToLocations < ActiveRecord::Migration[7.2]
  def change
    add_column :locations, :country_id, :integer
    add_column :locations, :province_id, :integer
  end
end
