class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  private
      def sign_up(resource_name, resource)
        true
      end
end