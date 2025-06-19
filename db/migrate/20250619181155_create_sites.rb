class CreateSites < ActiveRecord::Migration[7.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.references :town, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
