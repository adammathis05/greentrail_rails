require 'rails_helper'

RSpec.describe "SavedCommunities", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/saved_communities/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/saved_communities/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
