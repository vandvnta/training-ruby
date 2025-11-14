class Admin::DashboardController < Admin::BaseController
    layout "admin"
    def index
        @total_users = User.count
        @total_teams = Team.count
        @total_roles = Role.count
    end
end