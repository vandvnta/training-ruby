module Admin
    class RoleService
        attr_reader :role, :errors

        def initialize(role = nil)
           @role = role
           @errors = [] 
        end

        # CREATE
        def create(params)
            @role = Role.new(params)
            save_role
        end

        # UPDATE
        def update(params)
            return false unless @role

            @role.assign_attributes(params)
            save_role
        end

        # DESTROY
        def destroy
            return false unless role

            if role.users.exists?
            @errors << "This Role cannot be deleted because it is still in use."
            return false
            end

            role.destroy
            true
        rescue => e
            @errors << e.message
            false
        end

        def self.filter(params)
            roles = Role.all

            if params[:name].present?
                roles = roles.where("name LIKE ?", "%#{params[:name]}%")
            end

            roles.paginate(page: params[:page])
        end

        private

        def save_role
            if @role.save
                true
            else
                @errors = @role.errors.full_messages
                false
            end
        end
    end
end