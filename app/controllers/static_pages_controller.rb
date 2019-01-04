class StaticPagesController < ApplicationController

  def home
   if logged_in?
      @user = current_user
      if !params[:first_day].nil?
          @first_day = Date.parse(params[:first_day])
      else
              @first_day = Date.new(Date.today.year, Date.today.month)
      end
                @last_day = @first_day.end_of_month
                  @works = @user.works.where(day: @first_day..@last_day)
                  
        unless      @user.works.find_by(day: @first_day)
                      @first_day.all_month.each do |day|
                        Work.create!(day: day,user_id: @user.id)
                      end
        end
   end
  end

  def help
  end

  def about
  end

  def contact
  end
  
  def test
    @title = params[:title]
    respond_to do |format|
      format.html
      format.js
  end
  end
end