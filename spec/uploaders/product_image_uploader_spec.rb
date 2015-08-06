require 'carrierwave/test/matchers'

describe ProductImageUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  let(:product_image) { FactoryGirl.create(:product_image) }

  before do
    ProductImageUploader.enable_processing = true
    @uploader = ProductImageUploader.new(product_image, :name)
    @uploader.store!(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))
  end

  after do
    ProductImageUploader.enable_processing = false
    @uploader.remove!
  end

  describe 'the thumbnail version' do
    it "generates a png image 70 pixels wide" do
      expect(@uploader.thumbnail).to have_width(70)

    end
  end

  describe 'the small version' do
    it "generates a png image 230 pixels wide" do
      expect(@uploader.small).to have_width(230)
    end
  end

  describe 'the medium version' do
    it "generates a png image 400 pixels wide" do
      expect(@uploader.medium).to have_width(400)
    end
  end

  describe 'processed image' do
    it "generates a png image 1290 pixels wide" do
      expect(@uploader).to have_width(1290)
    end
  end
end