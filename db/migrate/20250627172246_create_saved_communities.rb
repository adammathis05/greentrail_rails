class CreateSavedCommunities < ActiveRecord::Migration[7.2]
  def change
    create_table :saved_communities do |t|
      t.references :traveler, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
