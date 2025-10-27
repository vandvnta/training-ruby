class User < ApplicationRecord
    belongs_to :team
    belongs_to :role
    validates :name, :email, presence: true
end
