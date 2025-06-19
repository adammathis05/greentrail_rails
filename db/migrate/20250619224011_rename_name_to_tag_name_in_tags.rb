class RenameNameToTagNameInTags < ActiveRecord::Migration[7.2]
  def change
      rename_column :tags, :name, :tag_name
  end
end
