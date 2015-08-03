require "rails_helper"

RSpec.describe Admin::UserMailer, type: :mailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      user.send_password_reset
    end
    let(:mail) { Admin::UserMailer.password_reset(user) }

    it "renders the subject" do
      expect(mail.subject).to eq('Reset password for Damian De Goa Admin')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eql(['no-reply@damiandegoa.com'])
    end

    it "assigns @user" do
      expect(mail.html_part.decoded).to include(user.name)
    end

    it "assigns @user.password_reset_token" do
      expect(mail.html_part.decoded).to include(recover_password_admin_users_url(user.password_reset_token))
    end
  end
end