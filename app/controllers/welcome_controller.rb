class WelcomeController < ApplicationController
  def index
    if not current_user.nil? and current_user.admin
      redirect_to admin_path
    else
      items = Item.all
      @new_items = items.order(:created_at).limit(5)
      @popular_items = items.order(:popularity).limit(5)
    end
  end
end