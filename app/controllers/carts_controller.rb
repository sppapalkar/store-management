class CartsController < ApplicationController
  before_action :set_cart_item, except: [:index, :clear]
  def index
    @cart_items = Cart.where(:user_id => current_user.id)
  end
  def add
    if age_restriction
        redirect_to items_path, notice: "Item is age restricted"
    else
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
  end

  def edit
  end

  def update
    respond_to do |format|
      if not quantity_valid?
        format.html { redirect_to cart_path, notice: 'Item quantity exceeds available quantity.' }
        format.json { render :index, status: :ok, location: @cart_item }
      elsif @cart_item.update(cart_update_params)
        format.html { redirect_to cart_path, notice: 'Item quantity updated.' }
        format.json { render :index, status: :ok, location: @cart_item }
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

  def clear
    cart_items = Cart.where(:user_id => current_user.id)
    cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to cart_path, notice: 'Cart Cleared'
  end

  private
  def quantity_valid?
    temp = cart_update_params
    if temp["quantity"].to_i > @item.quantity
      return false
    end
    return true
  end
  
  def cart_params
    params.permit(:item_id, :id)
  end

  def cart_update_params
    params.require(:cart).permit(:quantity)
  end
    # Use callbacks to share common setup or constraints between actions.
  def set_item
    unless @cart_item.nil?
      @item = Item.find(@cart_item.item_id)
    end
  end
  def set_cart_item
    if cart_params.key?(:item_id)
      @cart_item = Cart.where(user_id: current_user.id, item_id: cart_params[:item_id]).first
    else
      @cart_item = Cart.find(cart_params[:id])
    end
    set_item
  end
  def age_restriction
    item = Item.find(cart_params[:item_id])
    item.age_restricted_item and current_user.get_age < 18
  end
end
