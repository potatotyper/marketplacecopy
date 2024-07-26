class OmniauthCallbacksController < ApplicationController
  def google
    if Current.user == nil 
      return redirect_to root_path, notice: "Please create a site account first"
    else 
      if Current.user.google_account != nil || GoogleAccount.exists?(email: auth.info.email)
        return redirect_to root_path, notice: "Google account previously linked"
      else
        Current.user.google_account = GoogleAccount.create(
          email: auth.info.email,
          image: auth.info.image,
          token: auth.credentials.token,
          secret: "no secret",
        )
      end
    end
    
    redirect_to root_path, notice: "Successfully logged into google"
  end

  def auth 
    request.env['omniauth.auth']
  end
end
