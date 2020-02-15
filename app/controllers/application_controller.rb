class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :date_of_birth, :phone, :email, :password, :address, :apt, :city, :postal_code)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :phone, :password, :address, :apt, :city, :postal_code, :current_password)}
  end

  def after_sign_in_path_for(resource)
    if current_user.admin
      return admin_path
    else
      return root_path
    end
  end

end

