class User < ApplicationRecord
    validates :email, presence: true
    validates :username, presence: true, uniqueness: true

    has_secure_password
    
    has_one :google_account
    has_many :textposts
    has_many :itemposts
    has_many :itemcomments

    has_many :sent_chats, class_name: "Chat", foreign_key: "sender_id"
    has_many :received_chats, class_name: "Chat", foreign_key: "receiver_id"
    has_many :messages

    enum status: {
        regular: 0,
        commenter: 1,
        poster: 2
    }

    scope :all_except, ->(user) { where.not(id: user) }
    after_create_commit { broadcast_append_to "users" }
    has_many :messages

end
