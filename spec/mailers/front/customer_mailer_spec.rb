require "rails_helper"

RSpec.describe Front::CustomerMailer, type: :mailer do
  describe "password_reset" do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:mail) { Front::CustomerMailer.welcome(customer.id) }

    it "renders the subject" do
      expect(mail.subject).to eq('Welcome to Damian De Goa! Please activate your account.')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([customer.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eql(['no-reply@damiandegoa.com'])
    end

    it "assigns @customer" do
      expect(mail.html_part.decoded).to include(customer.name)
    end

    it "assigns @customer.activation_digest" do
      expect(mail.html_part.decoded).to include(activate_front_customer_url(customer.activation_digest))
    end
  end
end