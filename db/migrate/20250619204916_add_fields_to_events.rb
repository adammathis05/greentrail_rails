class AddFieldsToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :date, :date
    add_column :events, :category, :string
    add_reference :events, :site, null: false, foreign_key: true
  end
end
