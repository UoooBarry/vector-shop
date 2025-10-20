class HomeController < ApplicationController
  def index
    @products = Product.where.not(embedding: nil)
    @customers = Customer.where.not(embedding: nil)
  end

  def customer_details
    @selected_customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    respond_to do |format|
      format.turbo_stream
    end
  end
end
