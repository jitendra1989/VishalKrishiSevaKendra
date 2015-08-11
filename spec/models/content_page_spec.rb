require 'rails_helper'

RSpec.describe ContentPage, type: :model do
  let(:content_page) { FactoryGirl.create(:content_page) }
  it { expect(content_page).to be_valid }
  it { expect(ContentPage.menu_items).to eq(ContentPage.where(menu: true)) }
  it "has a valid title" do
  	content_page.title = nil
  	expect(content_page).to_not be_valid
  end
  it "has a valid content" do
  	content_page.content = nil
    expect(content_page).to_not be_valid
  end
  describe 'menu link' do
    it 'requires a link_tex if menu is selected' do
      content_page.link_text = nil
      content_page.menu = true
      expect(content_page).not_to be_valid
    end
  end
end
