require 'carrierwave/test/matchers'

describe BannerUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  let(:banner) { FactoryGirl.create(:banner) }

  before do
    BannerUploader.enable_processing = true
    @uploader = BannerUploader.new(banner, :image)
    @uploader.store!(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))
  end

  after do
    BannerUploader.enable_processing = false
    @uploader.remove!
  end

  describe 'the small version' do
    it "generates a png image 230 pixels wide" do
      expect(@uploader.small).to have_width(230)
    end
  end

  describe 'processed image' do
    it "generates a png image 990 pixels wide" do
      expect(@uploader).to have_width(990)
    end
  end
end