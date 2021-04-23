class User < ApplicationRecord
    has_secure_password
    
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :binder_name, length: { maximum: 30 }
end
