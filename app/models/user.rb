class User < ApplicationRecord
    has_secure_password
    has_many :categories
    
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :binder_name, length: { maximum: 30 }
end
