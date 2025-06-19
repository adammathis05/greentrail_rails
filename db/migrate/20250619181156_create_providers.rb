class CreateProviders < ActiveRecord::Migration[7.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.references :site, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
