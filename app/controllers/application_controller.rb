class ApplicationController < ActionController::Base
    helper_method :current_admin, :admin_logged_in?

    def current_admin
        @current_admin ||= User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
    end

    def admin_logged_in?
        !!current_admin
    end

    def require_admin_login
        redirect_to admin_login_path, alert: "Vui lòng đăng nhập!" unless admin_logged_in
    end
end
