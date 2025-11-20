class AddUniqueIndexToProviderTags < ActiveRecord::Migration[7.1]
  def change
    add_index :provider_tags, [ :provider_id, :tag_id ], unique: true
  end
end
