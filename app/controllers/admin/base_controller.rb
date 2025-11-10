class Admin::BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin!

    private

    def authenticate_admin!
        unless session[:admin_user_id].present?
            redirect_to admin_login_path, alert: "Vui lòng đăng nhập trước khi truy cập."
        end
    end
end