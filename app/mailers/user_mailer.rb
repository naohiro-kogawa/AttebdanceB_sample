class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント認証をお願いします。"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードのリセットをします。"
  end
end