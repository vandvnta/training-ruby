class User < ApplicationRecord
    belongs_to :team
    belongs_to :role

    has_one_attached :avatar

    # Password security
    has_secure_password
    
    # Validations
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
