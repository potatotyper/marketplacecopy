class User < ApplicationRecord
    validates :email, presence: true
    has_secure_password
    has_one :google_account

    enum status: {
        regular: 0,
        commenter: 1,
        poster: 2
    }
end
