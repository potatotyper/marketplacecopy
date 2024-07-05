# username: string
# email: string
# password_digest: string
# 
# password: string virtual
# password_confirmation: string 

class Admin < ApplicationRecord
    validates :email, presence: true
    has_secure_password
end
