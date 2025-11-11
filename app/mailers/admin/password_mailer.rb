class Admin::PasswordMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def reset_password
    @user = params[:user]
    @reset_link = edit_admin_password_url(@user.reset_password_token)
    mail(to: @user.email, subject: "Reset your password")
  end
end
