class CreateSites < ActiveRecord::Migration[7.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.references :town, foreign_key: { to_table: :locations }
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
