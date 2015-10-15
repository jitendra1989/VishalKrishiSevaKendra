# Preview all emails at http://localhost:3000/rails/mailers/front/customer_mailer
class Front::CustomerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/front/customer_mailer/welcome
  def welcome
    customer = Customer.first
    customer.activation_digest = 'XXXXXXXXXXXXXXXXXXXX'
    Front::CustomerMailer.welcome(customer)
  end

  def password_reset
    customer = Customer.first
    customer.password_reset_token = 'XXXXXXXXXXXXXXXXXXXX'
    customer.save!
    Front::CustomerMailer.password_reset(customer)
  end

end
