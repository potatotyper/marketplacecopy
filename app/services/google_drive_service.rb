require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'
require 'googleauth'
require "google/cloud/storage"
require 'google/apis/sheets_v4'

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
    folder_id = '1QSE_PksO7Wlg8aMTgNmHAK4WpG8u72rV'
    folders =  DRIVE.list_files(q: "mimeType='application/vnd.google-apps.folder' and trashed = false")
    puts "FOLDERS BELOW"
    puts folders.inspect
    fileslist = DRIVE.list_files(q: "'#{folder_id}' in parents and trashed = false")
    puts "FILES BELOW"
    id = 0
    fileslist.files.map do |file|
      DRIVE.get_file(file.id, download_dest: "app/assets/images/batchimages/#{file.name}")
      id = id+1
    end
  end
end

class GoogleCloudBucketService
  def initialize
    @storage = Google::Cloud::Storage.new(
      project_id: ENV['STORAGE_PROJECT_ID'],
      credentials: ENV['STORAGE_CREDS_PATH']
    )
    @bucket = @storage.bucket "batchuplaod_vidiotest"
  end

  def upload_to_bucket
    imagelist = []
    files = Dir.entries("app/assets/images/batchimages").select do |entry|
      File.file?(File.join("app/assets/images/batchimages", entry))
    end
    puts "FILES LIST BELOW"
    puts files.inspect
    files.each do |file_img|
      namesplit = file_img.split('#')
      @bucket.create_file "app/assets/images/batchimages/#{file_img}",
                          "main_folder/sub_folder/#{namesplit[0]}/#{namesplit[1]}"
      file_path = "main_folder/sub_folder/#{namesplit[0]}/#{namesplit[1]}"
      if ImageType.exists?(image_name: namesplit[1])
        ImageType.find_by(image_name: namesplit[1]).image_path = file_path
      else
        img = ImageType.new(image_name: namesplit[1], image_id: namesplit[0], image_path: file_path)
        puts "IMAGE DETAILS"
        puts img.inspect
        img.save ? imagelist << img : nil
      end
    end
    puts "LINKS BELOW"
  end
end

class GoogleSheetsService
  refresher = Google::TokenRefresher.new Current.user.google_account.refresh
  new_access_token = refresher.refresh_access_token

  SHEET = Google::Apis::SheetsV4::SheetsService.new
  SHEET.authorization = new_access_token

  SHEETID = "1aO5_gWo5sdWFA3_AKr3lrFHFKFYr2Y3uUoEtQC49adE"

  def gen_sheet
    puts SHEETID
    rows_to_append = []
    ImageType.all.each do |imag|
      rows_to_append << [imag.image_id, imag.image_name, imag.image_path]
    end
    puts "SHEETSAPPEND"
    puts rows_to_append.inspect
    range = "Sheet1!A:Z"  # Adjust the range if needed
    value_range = Google::Apis::SheetsV4::ValueRange.new(values: rows_to_append)
    SHEET.update_spreadsheet_value(
      SHEETID,
      range,
      value_range,
      value_input_option: 'RAW'
    )
  end
end