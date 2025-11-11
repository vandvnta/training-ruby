class ApplicationController < ActionController::Base
    helper_method :current_admin, :admin_logged_in?

    def current_admin
        @current_admin ||= User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
    end

    def admin_logged_in?
        !!current_admin
    end

    def require_admin_login
        unless current_admin
        flash[:alert] = "Please log in to access this page."
        redirect_to admin_login_path
        end
    end
end
