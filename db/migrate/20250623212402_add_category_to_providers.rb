class AddCategoryToProviders < ActiveRecord::Migration[7.2]
  def change
    add_column :providers, :category, :string
  end
end
