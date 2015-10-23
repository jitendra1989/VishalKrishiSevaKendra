require 'carrierwave/test/matchers'

describe CharacteristicImageUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  let(:characteristic_image) { FactoryGirl.create(:characteristic_image) }

  before do
    CharacteristicImageUploader.enable_processing = true
    @uploader = CharacteristicImageUploader.new(characteristic_image, :name)
    @uploader.store!(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))
  end

  after do
    CharacteristicImageUploader.enable_processing = false
    @uploader.remove!
  end

  describe 'the small version' do
    it "generates a png image 100 pixels wide" do
      expect(@uploader.small).to have_width(100)
    end
  end
end
