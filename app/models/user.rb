class User < ApplicationRecord
    belongs_to :team
    belongs_to :role

    has_one_attached :avatar

    # Password security
    has_secure_password
    
    # Validations

    validates :role_id, presence: true
    validates :team_id, presence: true

    validates :email, presence: true, uniqueness: true
    validates :email, format: {
        with: URI::MailTo::EMAIL_REGEXP, 
        message: "incorrect email format",
        allow_blank: true
    }
    validates :name, presence: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
