class HomeController < ApplicationController
  def index
    @products = Product.where.not(embedding: nil)
  end
end
