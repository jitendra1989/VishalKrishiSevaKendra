class PagesController < ApplicationController
  def index
    @products = Product.first(8)
  end

  def about
  end

  def projects
  end

  def clients
  end

  def contact
  end
end
