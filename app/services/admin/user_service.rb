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

        def self.filter(params)
            users = User.all

            if params[:name].present?
                users = users.where("name LIKE ?", "%#{params[:name]}%")
            end

            if params[:role_id].present?
                users = users.where(role_id: params[:role_id])
            end

            if params[:team_id].present?
                users = users.where(team_id: params[:team_id])
            end

            users.paginate(page: params[:page])
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