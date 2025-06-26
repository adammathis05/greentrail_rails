class AddDetailsToTravelers < ActiveRecord::Migration[7.2]
  def change
    add_column :travelers, :birthdate, :date
    add_column :travelers, :home_city, :string
    add_column :travelers, :home_country, :string
    add_column :travelers, :profile_image_url, :string
  end
end
