class ProductsController < ApplicationController
  before_action :fetch_home_data

  def show
    @product = Product.find(params[:id])
  end
end
