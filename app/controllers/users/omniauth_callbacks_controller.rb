class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    User.find(request.env["omniauth.params"]['id']).recruits << user if request.env["omniauth.params"]['id'] 

    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_session_path
    end
  end

  alias_method :facebook, :all

end
