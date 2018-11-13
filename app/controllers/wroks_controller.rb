class WroksController < ApplicationController
  def create
    @work= current_user.works.build(work_params)
    if @work.save
      flash[:success] = "出勤しました"
      redirect_to root_url
    end
  end
end
