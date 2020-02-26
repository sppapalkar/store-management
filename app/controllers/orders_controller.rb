class OrdersController < ApplicationController
  before_action :set_session, only: [:review]
  before_action :get_cart_items, :check_cart, :check_cards, :compute_totals, except: [:manage, :index, :return]

  def index
    if current_user.admin?
      parameters = search_params
      if parameters.nil? or (parameters[:user_id].empty? and parameters[:item_id].empty?)
        @orders = Order.all
      elsif not parameters[:user_id].empty? and not parameters[:item_id].empty?
        search_by_user_and_item(parameters[:user_id], parameters[:item_id])
      elsif not parameters[:user_id].empty?
        search_by_user(parameters[:user_id])
      else
        search_by_item(parameters[:item_id])
      end
    else
      @orders = Order.where(user_id: current_user.id)
    end
  end

  def manage
    @order = Order.find(order_params[:id])
    @order_items = Orderitem.where(order_id: @order.id)
  end

  def review
    @card = Card.new
  end

  def authenticate
    session['card_id'] = card_params[:id]
    session['otp'] = generate_otp
    OtpMailer.otp_email(@user).deliver
  end

  def create
    if verify_otp
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
    else
      redirect_to cart_path, :notice => "Invalid OTP - Purchase Cancelled"
    end
  end

  def return
    order_item = Orderitem.find(order_params[:orderitem_id])
    order = Order.find(order_params[:order_id])
    unless order_item.nil?
      order_item.update(status: 'Return Requested')
      redirect_to order_manage_path(order), notice: 'Status Updated'
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
  # Whitelist Order params
  def order_params
    params.permit(:id, :order_id, :orderitem_id)
  end
  # Whitelist Search params
  def search_params
    if params.has_key?(:search)
      params.require(:search).permit(:user_id, :item_id)
    end
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
    if current_user.get_age > 65
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
  # Update item quantities
  def update_item_quantities
    @cart_items.each do |cart_item|
      item = Item.find(cart_item.item_id)
      item.quantity -= cart_item.quantity
      item.save
    end
  end
  # Save order items
  def create_order_items
    @cart_items.each do |cart_item|
      item = Item.find(cart_item.item_id)
      if item.restricted_item
        order_item = Orderitem.new(:order_id => @order.id, :brand => item.brand, :name => item.name,
                                   :quantity => cart_item.quantity, :price => item.price, :status => 'Pending Approval')
      else
        order_item = Orderitem.new(:order_id => @order.id, :brand => item.brand, :name => item.name,
                                   :quantity => cart_item.quantity, :price => item.price, :status => 'Purchased')
      end
      @order_items.append(order_item)
    end
    update_item_quantities
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
    card = Card.find(session['card_id'])
    @order.card_holder = card.name
    @order.card_number = card.number
  end
  # Filter results based on User Id and Item Id
  def search_by_user_and_item(user_id,item_id)
    orderitems = Orderitem.where(:item_id => item_id)
    ids = []
    orderitems.each do |orderitem|
      ids.append(orderitem.order_id) if orderitem.order.user_id == user_id
    end
    @orders = Order.where(id:ids)
  end
  # Filter results based on User Id
  def search_by_user(user_id)
    @orders = Order.where(:user_id => user_id)
  end
  # Filter results based on Item Id
  def search_by_item(item_id)
    orderitems = Orderitem.where(:item_id => item_id)
    ids = []
    orderitems.each do |orderitem|
      ids.append(orderitem.order_id)
    end
    @orders = Order.where(id:ids)
  end
  def generate_otp
    rand.to_s[2..7]
  end
  def verify_otp
    session['otp'] == params[:otp][:code]
  end
end