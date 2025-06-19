class AddFieldsToSites < ActiveRecord::Migration[7.2]
  def change
    add_column :sites, :category, :string
    add_column :sites, :description, :string
    add_column :sites, :street_address, :string
    add_column :sites, :latitude, :decimal
    add_column :sites, :longitude, :decimal
    add_column :sites, :map_link, :string
  end
end
