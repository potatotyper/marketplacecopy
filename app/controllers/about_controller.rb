class AboutController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        puts "GSD LIST"
        puts GoogleDriveService.new.list
        GoogleCloudBucketService.new.upload_to_bucket
        GoogleSheetsService.new.gen_sheet
    end
    
    def test
        puts "Google SHeets Serivce"
        GoogleDriveService.new.list
    end
end