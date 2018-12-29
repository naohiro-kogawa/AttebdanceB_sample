class WorksController < ApplicationController
 
   def show
     @user = User.find(params[:id])
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
  
   def create
    #updateの処理をこちらのcreateに移動して、処理をわかりやすくしましょう！そのままコピペでいいと思いますが、ルーティングファイルとビューファイルの名前の修正が必要になると思います。
   end
  
  def update 
    # ここにeditページで更新する処理を書きます。なのでform_forはこのupdateアクションに飛ぶようにビューを修正してみてください！とりあえず、処理の内容は後回しでいいと思います！
   work = Work.find(params[:id]) #workのidがパラメーターで渡って来ていたので、workの検索をidで絞りました。
   if params[:button_type] == "start" && work.attendance_time.nil? #paramsはどういう形でコントローラーに渡ってくるかを確認するのがいいと思います。debuggerを仕込むか、raiseでパラメーターを確認しましょう！
    work.update(attendance_time: Time.zone.now) 
    flash[:success] = "今日も一日頑張りましょう！"
   elsif params[:button_type] == "end" && work.leaving_time.nil?
    work.update(leaving_time: Time.zone.now)
    flash[:success] = "お疲れ様でした！"

   end
   redirect_to work_url(current_user)
  end
  
  def edit
    # editにはedit(勤怠編集ページ)ページを表示するだけの処理をコーディングしてみてください！showページで勤怠情報は作成されているので、シンプルなコーディングになると思います。ですが、処理内容は後回しにして、適正なアクションに適正な処理がコーディングされていることを優先してみてください。
    # 処理の内容はその後に行いましょう！
    @user = User.find(params[:id])
    if !params[:first_day].nil?
         @first_day = Date.parse(params[:first_day])
    else
         @first_day = Date.new(Date.today.year, Date.today.month)
    end
        @last_day = @first_day.end_of_month
    # 以下に＠worksを移動。＠worksには任意のユーザーの月間のデータを入れたいので、whereメソッドを使用して、絞り込みしました！
       @works = @user.works.where(day: @first_day..@last_day)#ここは理解できる
    # 以下でビューを表示する前に、１ヶ月分の勤怠レコードが存在しなかったら、１ヶ月分の勤怠レコードを作成します。
       unless @user.works.find_by(day: @first_day)#unless=条件が偽だった時の処理
         @first_day.all_month.each do |day|
           Work.create!(day: day,user_id: @user.id)#createの後ろの！は通常より強い（破壊的）メソッド
         end
       end
  end
  
   private
    def works_params
      params.permit(works: [:attendance_time, :leaving_time, :remarks])[:works]
    end

end
