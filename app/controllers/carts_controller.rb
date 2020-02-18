class CartsController < ApplicationController
  def index
    @items = Cart.where(:user_id => current_user.id)
  end
  def add
    @cart = Cart.new(cart_params)
    @cart.user_id = current_user.id
    @cart.quantity = 1
    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_path, notice: 'Item successfully added to cart' }
        format.json { render 'carts/index', status: :created, location: @cart }
      else
        format.html { render 'items/index' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def cart_params
    params.require(:item).permit(:items_id)
  end
end
