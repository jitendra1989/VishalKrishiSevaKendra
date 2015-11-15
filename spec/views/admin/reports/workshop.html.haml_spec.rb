require 'rails_helper'

RSpec.describe "admin/reports/workshop", type: :view do
  let(:workshop_log) { WorkshopLog.all }
  let(:workshop_image_log) { WorkshopImageLog.all }

  it "renders attributes in <p>" do
    assign(:workshop_log, workshop_log)
    assign(:workshop_image_log, workshop_image_log)
    render
    expect(rendered).to match(/User/)
  end
end
