class WorksController < ApplicationController

  def show
    @user = User.find(params[:id])
     if    current_user.admin? 
     elsif current_user != User.find(params[:id]) 
           redirect_to(root_url) 
           flash[:warning] = "ほかのユーザにはアクセスできません"
     end
      if  !params[:first_day].nil?
          @first_day = Date.parse(params[:first_day])
      else
          @first_day = Date.new(Date.today.year, Date.today.month)
      end
            @last_day = @first_day.end_of_month
            @works = @user.works.where(day: @first_day..@last_day)
        unless  @user.works.find_by(day: @first_day)
                @first_day.all_month.each do |day|
                Work.create!(day: day,user_id: @user.id)
                end
        end
  end
  
    
  def edit
    @user = User.find(params[:id])
     if current_user.admin? 
     elsif current_user != User.find(params[:id]) 

        redirect_to(root_url) 
            flash[:warning] = "ほかのユーザにはアクセスできません"
     end
      if  !params[:first_day].nil?
          @first_day = Date.parse(params[:first_day])
      else
          @first_day = Date.new(Date.today.year, Date.today.month)
      end
            @last_day = @first_day.end_of_month
            @works = @user.works.where(day: @first_day..@last_day)
        unless  @user.works.find_by(day: @first_day)
                @first_day.all_month.each do |day|
                Work.create!(day: day,user_id: @user.id)
                end
        end
  end
  
  
  
  def update
    @user = current_user
    work = Work.find(params[:id])
    if params[:button_type] == "start" && work.attendance_time.nil?
      work.update(attendance_time: Time.zone.now.to_s(:long))
      flash[:success] = "今日も一日頑張りましょう！"
      elsif params[:button_type] == "end" && work.leaving_time.nil?
      work.update(leaving_time: Time.zone.now.to_s(:long))
      flash[:success] = "お疲れ様でした！"
    end
    redirect_to work_url(@user)
    
  end
  
  
  
  
  def edit_works
    @user = User.find(params[:id])
      works_params.each do |id, time|
        work = Work.find(id)
          if work.day > Date.current && !current_user.admin?
          elsif time["attendance_time"].blank? && time["leaving_time"].blank?
          elsif time["attendance_time"].blank? || time["leaving_time"].blank?
            flash[:warning] = '一部編集が無効となった項目があります。'
          elsif time["attendance_time"].to_s > time["leaving_time"].to_s
            flash[:warning] = '出社時間より退社時間が早い項目がありました'
          else
                work.update_attributes(time)
                  flash[:success] = '勤怠時間を更新しました。なお本日以降の更新はできません。'
          end
      end 
    redirect_to edit_work_path(@user, params:{ id: @user.id, first_day: params[:first_day]})
  end
  
  
  
  
  
   private
   
    def works_params
      params.permit(works: [:attendance_time, :leaving_time, :remarks])[:works]
    end

end
