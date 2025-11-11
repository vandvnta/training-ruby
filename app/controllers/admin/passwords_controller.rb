class Admin::PasswordsController < ApplicationController
  before_action :require_admin_login, only: [:edit_current, :update_current]
  layout "admin", only: [:edit_current, :update_current]
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.update(
        reset_password_token: SecureRandom.hex(10),
        reset_password_sent_at: Time.current
      )
      Admin::PasswordMailer.with(user: @user).reset_password.deliver_later
      redirect_to admin_login_path, notice: "We have emailed you instructions on how to reset your password."
    else
      flash.now[:alert] = "Email does not exist in the system."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])
    unless @user && @user.reset_password_sent_at > 30.minutes.ago
      redirect_to new_admin_password_path, alert: "The password reset link has expired."
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])
    if @user&.update(password_params.merge(reset_password_token: nil))
      flash[:notice] = "Password was reset successfully."
      redirect_to admin_login_path
    else
      flash.now[:alert] = "Unable to update password."
      render :edit, status: :unprocessable_entity
    end
  end

  # GET /admin/passwords/edit_current
  def edit_current
    @user = current_admin
  end

  # PATCH /admin/passwords/update_current
  def update_current
    @user = current_admin

    current_password = params[:user][:current_password]

    if @user.authenticate(current_password)
      if @user.update(password_params)
        redirect_to admin_dashboard_path, notice: "Password changed successfully."
      else
        flash.now[:alert] = "Could not update password."
        render :edit_current, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Current password is incorrect."
      render :edit_current, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
