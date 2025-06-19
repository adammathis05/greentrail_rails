class CreateProviderTags < ActiveRecord::Migration[7.2]
  def change
    create_table :provider_tags do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
