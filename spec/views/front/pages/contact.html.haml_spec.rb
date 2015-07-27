require 'rails_helper'

RSpec.describe "front/pages/contact", type: :view do

    it "renders attributes in <div>" do
      render
      expect(rendered).to match(/Address/)
      expect(rendered).to have_css('iframe')
    end
  end