class OrdersController < ApplicationController
  before_action :set_session, only: [:review]
  before_action :get_cart_items, :check_cart, :check_cards, :compute_totals
  def review
    @card = Card.new
  end

  def create
    @order = Order.new({:card_id => card_params[:id]})
    @card = Card.find(card_params[:id])
    @order.user_id = current_user.id
    @order.tax = @tax_total
    @order.discount = @discount
    @order.amount = @final_total
    if @order.save
      @order_items = []
      create_order_items
      if session[:item_id] == -1
        clear_cart
      end
    else
      redirect_to root_path, notice: 'Could Not Place the Order'
    end
  end

  private
  def item_params
    params.permit(:cart, :item_id)
  end
  def card_params
    params.require(:card).permit(:id)
  end
  def get_cart_items
    if session[:item_id] == -1
      @cart_items = Cart.where(user_id: current_user.id)
    else
      @cart_items = Cart.new(user_id: current_user.id, item_id: params[:item_id])
    end
  end
  def check_cart
    if @cart_items.first.nil?
      redirect_to cart_path, notice: "No items in cart"
    end
  end
  def compute_totals
    @tax_total = 0
    @sub_total = 0
    @cart_items.each do |cart_item|
      item = Item.find(cart_item.item_id)
      @sub_total += cart_item.quantity * item.price
      @tax_total += cart_item.quantity * item.price * (item.category.tax_slab/100)
    end
    compute_discount
    @final_total = @sub_total + @tax_total - @discount
  end
  def compute_discount
    @discount = 0.0
    if ((Date.parse(Time.now.strftime("%y/%m/%d")) - current_user.date_of_birth)/365).floor > 65
      @discount = @sub_total * (0.1)
    end
  end
  def set_session
    if item_params.key?(:item_id)
      session[:item_id] = params[:item_id]
    else
      session[:item_id] = -1
    end
    puts session.inspect
  end
  def create_order_items
    @cart_items.each do |cart_item|
      order_item = Orderitem.new({:order_id => @order.id, :item_id => cart_item.item_id, :quantity => cart_item.quantity})
      @order_items.append(order_item)
    end
    Orderitem.transaction do
      @order_items.each(&:save!)
    end
  end
  def clear_cart
    Cart.where(:user_id => current_user.id).delete_all
  end
  def check_cards
    unless Card.exists?(:user_id => current_user.id)
      redirect_to cards_path, notice: "Please add a credit card first"
    end
  end
end