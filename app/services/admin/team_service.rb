module Admin
    class TeamService
        attr_reader :team, :errors
        
        def initialize(team = nil)
            @team = team
            @errors = []
        end

        # CREATE
        def create(params)
            @team = Team.new(params)
            save_team
        end

        # UPDATE
        def update(params)
            return false unless @team

            @team.assign_attributes(params)
            save_team
        end

        # DESTROY
        def destroy
            return false unless team

            if team.users.exists?
            @errors << "This Team cannot be deleted because it is still in use."
            return false
            end

            team.destroy
            true
        rescue => e
            @errors << e.message
            false
        end

        def self.filter(params)
            teams = Team.all

            if params[:name].present?
                teams = teams.where("name LIKE ?", "%#{params[:name]}%")
            end

            teams.paginate(page: params[:page])
        end

        private

        def save_team
            if @team.save
                true
            else
                @errors = @team.errors.full_messages
                false
            end
        end
    end
end