class Admin::TeamsController < Admin::BaseController
    before_action :set_team, only: %i[ show edit update destroy ]

    # GET /admin/teams or /teams.json
    def index
        @teams = Team.all
    end

    # GET /admin/teams/1 or /teams/1.json
    def show
    end

    # GET /admin/teams/new
    def new
        @team = Team.new
    end

    # GET /admin/teams/1/edit
    def edit
    end

    # POST /admin/teams or /teams.json
    def create
        service = Admin::TeamService.new
        if service.create(team_params)
            redirect_to admin_team_path(service.team), notice: "Team was successfully created."
        else
            @team = service.team
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /admin/teams/1 or /teams/1.json
    def update
        service = Admin::TeamService.new(@team)
        if service.update(team_params)
            redirect_to admin_team_path(service.team), notice: "Team was successfully updated.", status: :see_other
        else
            @team = service.team
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /admin/teams/1 or /teams/1.json
    def destroy
        service = Admin::TeamService.new(@team)
        if service.destroy
            redirect_to admin_teams_path, notice: "Team was successfully destroyed.", status: :see_other
        else
            redirect_to admin_team_path(@team), alert: service.errors.join(", ")
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
        @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
        params.require(:team).permit(:name, :description)
    end
end
