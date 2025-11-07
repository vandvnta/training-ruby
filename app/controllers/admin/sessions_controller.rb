class Admin::SessionsController < ApplicationController
    layout "login"
    
    def new
        render "sessions/new"
    end

    def create
        service = Admin::LoginService.new(params[:email], params[:password])
        result = service.call

        if result.success?
            session[:admin_user_id] = result.user.id
            redirect_to admin_dashboard_path, notice: "Đăng nhập thành công!"
        else
            flash.now[:alert] = result.error_message
            render "sessions/new", status: :unprocessable_entity
        end
    end

    def destroy
        session.delete(:admin_user_id)
        redirect_to admin_login_path, notice: "Đã đăng xuất!"
    end
end
