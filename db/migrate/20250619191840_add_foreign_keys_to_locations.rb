class AddForeignKeysToLocations < ActiveRecord::Migration[7.2]
  def change
    add_reference :locations, :country, foreign_key: { to_table: :locations }
    add_reference :locations, :province, foreign_key: { to_table: :locations }
  end
end
