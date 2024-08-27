class User < ApplicationRecord
    validates :email, presence: true
    validates :username, presence: true, uniqueness: true

    has_secure_password
    
    has_one :google_account
    has_many :textposts
    has_many :itemposts
    has_many :itemcomments

    enum status: {
        regular: 0,
        commenter: 1,
        poster: 2
    }
end
