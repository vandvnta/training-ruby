class User < ApplicationRecord
    belongs_to :team
    belongs_to :role

    has_one_attached :avatar

    # Password security
    has_secure_password

    # Reset password
    def generate_reset_token!
        update!(
            reset_password_token: SecureRandom.hex(20),
            reset_password_sent_at: Time.current
        )
    end

    def reset_token_valid?
        reset_password_sent_at && reset_password_sent_at > 30.minutes.ago
    end

    def clear_reset_token!
        update!(reset_password_token: nil, reset_password_sent_at: nil)
    end
    
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
