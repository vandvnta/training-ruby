module Admin
    class UserService
        attr_reader :user, :errors

        def initialize(user = nil)
            @user = user
            @errors = []
        end

        # CREATE
        def create(params)
            @user = User.new(params)
            save_user
        end

        # UPDATE
        def update(params)
            return false unless @user

            @user.assign_attributes(params)
            save_user
        end

        # DESTROY
        def destroy
            return false unless @user

            @user.destroy
            true
        rescue => e
            @errors << e.message
            false
        end

        private

        def save_user
            if @user.save
                true
            else
                @errors = @user.errors.full_messages
                false
            end
        end
    end
end