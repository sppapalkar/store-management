class AdminController < ApplicationController
  def index
    unless user_signed_in? and current_user.admin
      redirect_to root_path, notice: 'You dont have the rights to access the page'
    end
  end
  def users
    @users = User.all
  end
end