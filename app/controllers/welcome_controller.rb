class WelcomeController < ApplicationController
  def index
    if not current_user.nil? and current_user.admin
      redirect_to admin_path
    else
      items = Item.all
      @new_items = items.order('created_at DESC').limit(4)
      @popular_items = items.order('popularity DESC').limit(4)
    end
  end
end