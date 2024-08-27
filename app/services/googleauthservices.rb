module Google  
    class TokenRefresher
        def initialize(refresh_token)
            @refresh_token = refresh_token
        end
  
        def refresh_access_token
            client_id = ENV['GOOGLE_CLIENT_ID']
            client_secret = ENV['GOOGLE_CLIENT_SECRET']
      
            credentials = Google::Auth::UserRefreshCredentials.new(
            client_id: client_id,
            client_secret: client_secret,
            refresh_token: Current.user.google_account.refresh
            )
          
            credentials.fetch_access_token!
            credentials.access_token
        end
    end

    def self.verify_google_token(token)
        uri = URI("https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{token}")
        
        response = Net::HTTP.get(uri)
        puts "VERIF RESPOSNE BELOW"
        puts response
        JSON.parse(response)
    end
end