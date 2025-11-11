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
        role = Role.find(params[:id])
        service = Admin::RoleService.new(role)

        if service.destroy
            flash[:notice] = "Role has been deleted."
        else
            flash[:alert] = service.errors.join(", ")
        end

        redirect_to admin_roles_path
    end

    private
    def set_role
        @role = Role.find(params[:id])
    end

    def role_params
        params.require(:role).permit(:name, :description)
    end
end
