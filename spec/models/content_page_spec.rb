require 'rails_helper'

RSpec.describe ContentPage, type: :model do
  let(:content_page) { FactoryGirl.create(:content_page) }
  it { expect(content_page).to be_valid }
  it "has a valid title" do
  	content_page.title = nil
  	expect(content_page).to_not be_valid
  end
  it "has a valid content" do
  	content_page.content = nil
  	expect(content_page).to_not be_valid
  end
  it "has a valid slug" do
  	content_page.slug = nil
  	expect(content_page).to_not be_valid
  end
end
