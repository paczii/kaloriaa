require 'rails_helper'

RSpec.describe "Distances", type: :request do
  describe "GET /distances" do
    it "works! (now write some real specs)" do
      get distances_path
      expect(response).to have_http_status(200)
    end
  end
end
