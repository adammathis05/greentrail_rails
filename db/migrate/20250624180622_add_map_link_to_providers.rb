class AddMapLinkToProviders < ActiveRecord::Migration[7.2]
  def change
    add_column :providers, :map_link, :string
  end
end
