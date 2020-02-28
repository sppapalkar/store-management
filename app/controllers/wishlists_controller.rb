class WishlistsController < ApplicationController
  before_action :check_logged_in
  def index
    @wishlist = Wishlist.where(:user_id => current_user.id)
  end
  def add
    @wish_item = Wishlist.new(:user_id => current_user.id, :item_id => wishlist_params[:item_id])
    if Wishlist.exists?(:user_id => current_user.id, :item_id => wishlist_params[:item_id])
      redirect_to items_path, notice: 'Item already in wishlist!'
    else
      respond_to do |format|
        if @wish_item.save
          format.html { redirect_to items_path, notice: 'Item added to wishlist.'}
          format.json { render :index, status: :created, location: @wish }
        else
          format.html { redirect_to items_path, notice: 'Something went wrong' }
          format.json { render json: @wish_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  def destroy
    @wish_item = Wishlist.find(wishlist_params[:id])
    @wish_item.destroy
    respond_to do |format|
      format.html { redirect_to wishlist_path, notice: 'Item was removed from wishlist.' }
      format.json { head :no_content }
    end
  end
  private
  def wishlist_params
    params.permit(:id, :item_id)
  end
  def check_logged_in
    unless user_signed_in?
      redirect_to root_path, notice: 'Please Sign In'
    end
  end
end
