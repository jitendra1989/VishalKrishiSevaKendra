require 'rails_helper'

RSpec.describe Front::PagesController, type: :controller do

  let(:page) { FactoryGirl.create(:content_page) }
  describe "GET #show" do
    it "returns http success" do
      get :show, id: page
      expect(assigns(:page)).to eq(page)
    end
  end


  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #projects" do
    it "returns http success" do
      get :projects
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #clients" do
    it "returns http success" do
      get :clients
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
  end

end
