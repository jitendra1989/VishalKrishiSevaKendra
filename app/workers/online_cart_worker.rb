class OnlineCartWorker
  include Sidekiq::Worker
  def perform(cart_id)
    cart = OnlineCart.find(cart_id)
    cart.return_blocked_stock
  end
end