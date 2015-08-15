# Preview all emails at http://localhost:3000/rails/mailers/front/order_mailer
class Front::OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/front/order_mailer/success
  def success
    order = OnlineOrder.last
    Front::OrderMailer.success(order)
  end

end
