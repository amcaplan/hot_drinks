require 'rails_helper'

RSpec.describe "Machines", type: :request do
  describe "GET /hot_drinks_machines" do
    it "works! (now write some real specs)" do
      get hot_drinks_machines_path
      expect(response).to have_http_status(200)
    end
  end
end
