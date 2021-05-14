class Category < ApplicationRecord
    belongs_to :user
    # has_many :recipes, dependent: :delete_all
end
