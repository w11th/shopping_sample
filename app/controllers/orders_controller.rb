class OrdersController < ApplicationController
  before_action :auth_user
  
  def new
    fetch_home_data
    @shopping_carts = ShoppingCart.find_by_user_uuid(current_user.uuid)
      .order("id desc").includes([:product => [:main_product_image]])
  end

  def create
  end
end
