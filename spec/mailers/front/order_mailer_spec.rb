require "rails_helper"

RSpec.describe Front::OrderMailer, type: :mailer do
  let(:online_order) { FactoryGirl.create(:online_order) }
  describe "Order Success" do
    let(:mail) { Front::OrderMailer.success(online_order) }

    it "renders the subject" do
      expect(mail.subject).to eq('Your Order with Damian De Goa.')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([online_order.customer.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eql(['no-reply@damiandegoa.com'])
    end

    it "assigns @customer" do
      expect(mail.html_part.decoded).to include(online_order.customer.name)
    end
    it 'has 1 attachments' do
      expect(mail.attachments.size).to eq(1)
      expect(mail.attachments[0].content_type).to start_with('application/pdf')
      expect(mail.attachments[0].filename).to eq("invoice_#{online_order.id}.pdf")
    end
  end
end