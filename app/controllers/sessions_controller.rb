class SessionsController < ApplicationController
  force_ssl
  
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if user.valid?
      sign_in user
    	flash[:success] = "Welcome #{user.first_name}"
    else
    	flash[:error] = user.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    sign_out
    flash[:notice] = "Signed out"
    redirect_to root_path
  end
end
