class Admin::BaseController < ApplicationController
    layout "admin"
    helper_method :current_admin

    before_action :authenticate_admin!

    private

    def authenticate_admin!
        unless session[:admin_user_id].present?
            redirect_to admin_login_path, alert: "Please login before accessing."
        end
    end

    def current_admin
        @current_admin ||= User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
    end
end