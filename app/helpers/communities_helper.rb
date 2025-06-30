module CommunitiesHelper

    def community_image_url(community)
    if community.hero_image_url.present?
      "communities/#{community.hero_image_url}"
    else
      sample_images = %w[
        sample_hero_image_1.jpg
        sample_hero_image_2.jpg
        sample_hero_image_3.jpg
      ]
      "communities/#{sample_images.sample}"
    end
  end

end
