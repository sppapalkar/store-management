class CartsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  def index
    @cart_items = Cart.where(:user_id => current_user.id)
  end
  def add
    # @new_item = Cart.new(cart_params)
    # @new_item.user_id = current_user.id
    # @new_item.quantity = 1
    @cart_item = Cart.where(user_id: current_user.id, item_id: cart_params[:item_id]).first
    if @cart_item.nil?
      @new_item = Cart.new(cart_params)
      @new_item.user_id = current_user.id
      @new_item.quantity = 1
      respond_to do |format|
        if @new_item.save
          format.html { redirect_to cart_path, notice: 'Item successfully added to cart'}
          format.json { render 'carts/index', status: :created, location: @new_item }
        else
          format.html { render 'items/index' }
          format.json { render json: @new_item.errors, status: :unprocessable_entity }
        end
      end
    else
      params[:cart] = {:quantity => @cart_item.quantity + 1}
      update
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @cart_item.update(cart_update_params)
        format.html { redirect_to cart_path, notice: 'Item quantity updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def cart_params
      params.require(:item).permit(:item_id)
    end

  def cart_update_params
    params.require(:cart).permit(:quantity)
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @cart_item = Cart.find(params[:id])
      @item = Item.find(@cart_item.item_id)
    end
end
