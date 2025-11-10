class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[ show edit update destroy ]

    # GET /admin/users or /users.json
    def index
        @users = User.all
    end

    # GET /admin/users/1 or /users/1.json
    def show
    end

    # GET /admin/users/new
    def new
        @user = User.new
    end

    # GET /admin/users/1/edit
    def edit
    end

    # POST /admin/users or /users.json
    def create
        service = Admin::UserService.new
        if service.create(user_params)
            redirect_to admin_user_path(service.user), notice: "User was successfully created."
        else
            @user = service.user
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /admin/users/1 or /users/1.json
    def update
        service = Admin::UserService.new(@user)
        if service.update(user_params)
            redirect_to admin_user_path(service.user), notice: "User was successfully updated.", status: :see_other
        else
            @user = service.user
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /admin/users/1 or /users/1.json
    def destroy
        service = Admin::UserService.new(@user)
        if service.destroy
            redirect_to admin_users_path, notice: "User was successfully destroyed.", status: :see_other
        else
            redirect_to admin_user_path(@team), alert: service.errors.join(", ")
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:name, :email, :role_id, :team_id, :password, :password_confirmation, :avatar)
    end
end
