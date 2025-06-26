class AddHeroImageUrlToCommunities < ActiveRecord::Migration[7.2]
  def change
    add_column :communities, :hero_image_url, :string
  end
end
