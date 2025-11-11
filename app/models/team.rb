class Team < ApplicationRecord
    has_many :users, dependent: :restrict_with_error, inverse_of: :team

    before_destroy :check_users

    private

    def check_users
        if users.exists?
            errors.add(:base, "This team is being used by a user and cannot be deleted.");
            throw(:abort)
        end
    end

    validates :name, presence: true
end
