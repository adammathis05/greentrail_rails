class AddFieldsToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :description, :text, null: false
    add_reference :communities, :community_center_site, foreign_key: { to_table: :sites }
  end
end
