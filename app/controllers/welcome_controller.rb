class WelcomeController < ApplicationController
  def index
    if not current_user.nil? and current_user.admin
      redirect_to admin_path
    end
  end
end