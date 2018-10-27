class WroksController < ApplicationController
    def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿が完了しました。"
      redirect_to root_url
  end
  end
end
