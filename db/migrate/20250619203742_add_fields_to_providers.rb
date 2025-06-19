class AddFieldsToProviders < ActiveRecord::Migration[7.2]
  def change
    add_column :providers, :service, :string
    add_column :providers, :description, :text
  end
end
