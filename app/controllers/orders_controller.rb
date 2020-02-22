class OrdersController < ApplicationController
  before_action :set_session, only: [:review]
  before_action :get_cart_items, :check_cart, :check_cards, :compute_totals, except: [:index]

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def review
    @card = Card.new
  end

  def create
    @order = Order.new
    assign_order_attributes
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
  # Whitelist Item params
  def item_params
    params.permit(:cart, :item_id)
  end
  # Whitelist Card params
  def card_params
    params.require(:card).permit(:id)
  end
  # Fetch list of items for order
  def get_cart_items
    if session[:item_id] == -1
      @cart_items = Cart.where(user_id: current_user.id)
    else
      @cart_items = []
      @cart_items.append(Cart.new(user_id: current_user.id, item_id: session[:item_id], quantity: 1))
    end
  end
  # Redirect if cart is empty
  def check_cart
    if @cart_items.first.nil?
      redirect_to cart_path, notice: "No items in cart"
    end
  end
  # Redirect if no cards exists
  def check_cards
    unless Card.exists?(:user_id => current_user.id)
      redirect_to cards_path, notice: "Please add a credit card first"
    end
  end
  # Set session variables
  def set_session
    session[:item_id] = if item_params.key?(:item_id)
      params[:item_id]
    else
      -1
    end
  end
  # Compute discount for senior citizen
  def compute_discount
    @discount = 0.0
    if ((Date.parse(Time.now.strftime("%y/%m/%d")) - current_user.date_of_birth)/365).floor > 65
      @discount = @sub_total * (0.1)
    end
  end
  # Compute totals for order
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
  # Save order items
  def create_order_items
    @cart_items.each do |cart_item|
      order_item = Orderitem.new(:order_id => @order.id, :item_id => cart_item.item_id,
                                  :quantity => cart_item.quantity, :status => 'Complete')
      @order_items.append(order_item)
    end
    Orderitem.transaction do
      @order_items.each(&:save!)
    end
  end
  # Clear User cart
  def clear_cart
    Cart.where(:user_id => current_user.id).delete_all
  end
  # Assign attributes to order
  def assign_order_attributes
    @order.status = 'Complete'
    # User Details
    @order.user_id = current_user.id
    @order.phone = current_user.phone
    @order.address = current_user.address
    @order.apt = current_user.apt
    @order.apt = current_user.city
    @order.postal_code = current_user.postal_code
    # Sub Totals
    @order.tax = @tax_total
    @order.discount = @discount
    @order.amount = @final_total
    # Card Details
    card = Card.find(card_params[:id])
    @order.card_holder = card.name
    @order.card_number = card.number
  end
end