class CreateTowns < ActiveRecord::Migration[7.2]
  def change
    create_table :towns do |t|
      t.string :name
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
