class Admin::RolesController < Admin::BaseController
    before_action :set_role, only: %i[ show edit update destroy ]

    # GET /admin/roles or /roles.json
    def index
        @roles = Role.all
    end

    # GET /admin/roles/1 or /roles/1.json
    def show
    end

    # GET /admin/roles/new
    def new
        @role = Role.new
    end

    # GET /admin/roles/1/edit
    def edit
    end

    # POST /admin/roles or /roles.json
    def create
        service = Admin::RoleService.new
        if service.create(role_params)
            redirect_to admin_role_path(service.role), notice: "Role was successfully created."
        else
            @role = service.role
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /admin/roles/1 or /roles/1.json
    def update
        service = Admin::RoleService.new(@role)
        if service.update(role_params)
            redirect_to admin_role_path(service.role), notice: "Role was successfully updated.", status: :see_other
        else
            @role = service.role
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /admin/roles/1 or /roles/1.json
    def destroy
        service = Admin::RoleService.new(@role)
        if service.destroy
            redirect_to admin_roles_path, notice: "Role was successfully destroyed.", status: :see_other
        else
            redirect_to admin_role_path(@role), alert: service.errors.join(", ")
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
        @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
        params.require(:role).permit(:name, :description)
    end
end
