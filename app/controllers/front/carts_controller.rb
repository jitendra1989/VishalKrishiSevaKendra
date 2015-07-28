class Front::CartsController < Front::ApplicationController
  def add
    cart = OnlineCart.find(session[:online_cart_id]) if session[:online_cart_id]
    unless cart
      cart = OnlineCart.find_or_create_by(customer: current_customer)
      session[:online_cart_id] = cart.id
    end
    cart.add_item(params[:product_id], params[:quantity])
    redirect_to edit_front_cart_url, flash: { success: 'Item successfully added to cart.' }
  end

  def edit
    @cart = session[:online_cart_id] ? OnlineCart.find(session[:online_cart_id]) : OnlineCart.new
  end

  def update
    cart = OnlineCart.find(session[:online_cart_id])
    cart.update_item(params[:product_id], params[:quantity])
    redirect_to edit_front_cart_url, flash: { success: 'Your cart was successfully updated.' }
  end

  def remove
    cart = OnlineCart.find(session[:online_cart_id])
    cart.destroy_item(params[:product_id])
    redirect_to edit_front_cart_url
  end
end
