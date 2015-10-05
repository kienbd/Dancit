class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def after_omniauth_failure_path_for(scope)
    session_path(scope)
  end

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        #{provider}_handler
        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  protected

  def facebook_handler
    token = request.env["omniauth.auth"]["credentials"]["token"]
    permissions = facebook_permissions(token)
    if !permissions.include?("email") # incase user deny email permission
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end

  end

  def google_oauth2_handler
  end

  def twitter_handler
  end

  def facebook_permissions token
    graph = Koala::Facebook::API.new(token)
    permissions = graph.get_connections('me','permissions')
    permissions.map { |p| p['permission'] if p["status"] == "granted" }
  end

end
