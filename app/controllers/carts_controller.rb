class CartsController < ApplicationController

  def index
    @items = Cart.where(:user_id => current_user.id)
  end

end
