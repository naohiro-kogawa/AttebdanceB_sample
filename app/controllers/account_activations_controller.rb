class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "新規登録が完了いたしました！"
      redirect_to user
    else
      flash[:danger] = "登録完了リンクが無効です"
      redirect_to root_url
    end
  end
end