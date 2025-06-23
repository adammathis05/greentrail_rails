class AddSlugToCommunities < ActiveRecord::Migration[7.2]
  def change
    add_column :communities, :slug, :string
    add_index :communities, :slug, unique: true
  end
end
