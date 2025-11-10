class Admin::PasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    puts "vandv test reset password"
    if @user
      @user.update(
        reset_password_token: SecureRandom.hex(10),
        reset_password_sent_at: Time.current
      )
      Admin::PasswordMailer.with(user: @user).reset_password.deliver_later
      redirect_to admin_login_path, notice: "Chúng tôi đã gửi email hướng dẫn đặt lại mật khẩu."
    else
      flash.now[:alert] = "Email không tồn tại trong hệ thống."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])
    unless @user && @user.reset_password_sent_at > 30.minutes.ago
      redirect_to new_admin_password_path, alert: "Liên kết đặt lại mật khẩu đã hết hạn."
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])
    if @user&.update(password_params.merge(reset_password_token: nil))
      redirect_to admin_login_path, notice: "Mật khẩu đã được đặt lại thành công."
    else
      flash.now[:alert] = "Không thể cập nhật mật khẩu."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
