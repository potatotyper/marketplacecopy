require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'
require 'googleauth'

module Google
  class AccessToken
    attr_reader :token
    def initialize(token)
      @token = token
    end

    def apply!(headers)
      headers['Authorization'] = "Bearer #{@token}"
    end
  end

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
end

class GoogleDriveService    
  refresher = Google::TokenRefresher.new Current.user.google_account.refresh
  new_access_token = refresher.refresh_access_token

  DRIVE = Google::Apis::DriveV3::DriveService.new
  DRIVE.authorization = new_access_token

  def list
    # Search for files in Drive (first page only)
    # 1QSE_PksO7Wlg8aMTgNmHAK4WpG8u72rV
    #
    folder_id = '1QSE_PksO7Wlg8aMTgNmHAK4WpG8u72rV'
    folders =  DRIVE.list_files(q: "mimeType='application/vnd.google-apps.folder' and trashed = false")
    puts "FOLDERS BELOW"
    puts folders.inspect
    fileslist = DRIVE.list_files(q: "'#{folder_id}' in parents and trashed = false")
    puts "FILES BELOW"
    id = 0
    fileslist.files.map do |file|
      DRIVE.get_file(file.id, download_dest: "app/assets/images/image#{id}.jpg")
      id = id+1
    end
  end
end
