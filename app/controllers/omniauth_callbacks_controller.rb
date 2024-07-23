class OmniauthCallbacksController < ApplicationController
  def google
    if Current.user == nil 
      return redirect_to root_path, notice: "Please create a site account first"
    else 
      google_acc = Current.user.google_account.where(email: auth.info.email).first_or_initialize
      google_acc.update(
        email: auth.info.email,
        image: auth.info.image,
        token: auth.credentials.token,
        secret: "no secret",
      )
    end

    
    redirect_to root_path, notice: "Successfully logged into google"
  end

  def auth 
    request.env['omniauth.auth']
  end
end
