require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'

class OmniauthCallbacksController < ApplicationController
  def google
    if Current.user == nil 
      return redirect_to index_path, notice: "Please create a site account first"
    else 
      if Current.user.google_account != nil || GoogleAccount.exists?(email: auth.info.email)
        Current.user.google_account.token = auth.credentials.token
        return redirect_to index_path, notice: "Google account previously linked"
      else
        Current.user.google_account = GoogleAccount.create(
          email: auth.info.email,
          image: auth.info.image,
          token: auth.credentials.token,
          refresh: auth.credentials.refresh_token,
        )
      end
    end
    redirect_to index_path, notice: "Successfully logged into google"
  end

  def auth 
    request.env['omniauth.auth']
  end
end
