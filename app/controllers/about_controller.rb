class AboutController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        puts "GSD LIST"
        puts GoogleDriveService.new.list
        GoogleCloudBucketService.new.upload_to_bucket
    end
    
end