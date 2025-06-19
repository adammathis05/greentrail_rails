class AddTypeToLocations < ActiveRecord::Migration[7.2]
  def change
    add_column :locations, :type, :string
  end
end
