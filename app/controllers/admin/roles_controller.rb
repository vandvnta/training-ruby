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
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_role_path(@role), notice: "Role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/roles/1 or /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to admin_role_path(@role), notice: "Role was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/roles/1 or /roles/1.json
  def destroy
    @role = Role.find(params[:id])
    if @role.destroy
      redirect_to admin_roles_path, notice: "Role was successfully deleted."
    else
      redirect_to admin_roles_path, alert: @role.errors.full_messages.to_sentence
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
