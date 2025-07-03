class CommunitiesController < ApplicationController
  before_action :authenticate_traveler!, unless: :public_page?
  before_action :set_community, only: [:show]
  skip_before_action :authenticate_traveler!, only: [:search]

  def show
    @all_categories = ["Explore", "Stay", "Eat", "Events", "Amenities"]
    @grouped_providers = @community.providers.includes(:site, :tags).group_by { |p| p.category.titleize }
  end

  # def index
  #   if params[:q].present?
  #     query = params[:q].downcase
  #     puts "Search query: #{params[:q]}"

  #     @communities = Community
  #       .joins(town: { province: :country })
  #       .where(
  #         "LOWER(communities.name) LIKE :q OR
  #         LOWER(locations.name) LIKE :q OR
  #         LOWER(provinces_locations.name) LIKE :q OR
  #         LOWER(countries_locations.name) LIKE :q",
  #         q: "%#{query}%"
  #       )

  #     puts "@communities count: #{@communities.count}"
  #   else
  #     @communities = Community.all
  #     puts "Showing all communities"
  #   end
  # end

  def search
    query = params[:q].to_s.downcase
    country_id = params[:country_id]

    @communities = Community.joins(town: { province: :country })
                            .where("LOWER(communities.name) LIKE ? OR LOWER(locations.name) LIKE ? OR LOWER(provinces_locations.name) LIKE ? OR LOWER(countries_locations.name) LIKE ?",
                                  "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
                            .distinct

    if country_id.present?
      @communities = @communities.where(countries: { id: country_id })
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "search_results",
          partial: "communities/results",
          locals: { communities: @communities, searched: true }
        )
      end

      format.html { redirect_to communities_path(q: query) }
    end
  end
  
  private

  def set_community
    @community = Community.friendly.find(params[:id])
  end
end