class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  private
    def sign_up(resource_name, resource)
      true
    end

  def after_sign_up_path_for(resource)
    if user_signed_in? and current_user.admin
      return users_path
    else
      return new_user_session_path
    end
  end
end