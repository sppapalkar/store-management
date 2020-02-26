# frozen_string_literal: true
class ItemsController < ApplicationController
  before_action :check_admin, except: %i[show index subscribe]
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    filters = filter_params
    unless filters.nil?
      filter_items_by_brand(filters[:brand]) unless filters[:brand].empty?
      filter_items_by_category(filters[:category_id]) unless filters[:category_id].empty?
      if filters.has_key?(:availability)
        filter_items_by_availability(filters[:availability])
      end
      if filters.has_key?(:sort)
        sort_items(filters[:sort])
      end
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def subscribe
    subscription = Subscription.new(:item_id => item_params[:id])
    subscription.email = current_user.email
    if Subscription.exists?(:item_id => item_params[:id], :email => subscription.email)
      redirect_to items_path, notice: 'Item already subscribed'
    else
      subscription.save
      redirect_to items_path, notice: 'Item subscribed for alerts'
    end
  end

  private
  # Check if Admin has logged In
  def check_admin
    unless user_signed_in? && current_user.admin
      redirect_to root_path, notice: 'You dont have the rights to access the page'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:id, :name, :brand, :category_id, :restricted_item,
                                 :age_restricted_item, :quantity, :price, :popularity)
  end

  def filter_params
    if params.key?(:filters)
      params.require(:filters).permit(:brand, :category_id, :availability, :sort)
    end
  end

  def filter_items_by_brand(brand)
    @items = @items.select { |item| item.brand == brand }
  end

  def filter_items_by_category(id)
    @items = @items.select { |item| item.category_id == id.to_i }
  end

  def filter_items_by_availability(availability)
    if availability == "A"
      @items = @items.select { |item| item.quantity > 0 }
    else
      @items = @items.select { |item| item.quantity == 0 }
    end
  end

  def sort_items(key)
    if key == "P"
      @items.sort_by(&:popularity)
    elsif key == "C"
      @items = @items.sort_by(&:price)
    end
  end
end
