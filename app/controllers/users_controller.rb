class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
 def index
    @users = User.paginate(page: params[:page])
 end
   
   def show
     

     @user = User.find(params[:id])
     @works = @user.works.find_by(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    # @likes = Like.where(micropost_id: params[:micropost_id])
     
     if !params[:first_day].nil?
      @first_day = Date.parse(params[:first_day])
     else
      @first_day = Date.new(Date.today.year, Date.today.month)
     end
     @last_day = @first_day.end_of_month
     
     redirect_to(root_url) unless current_user.admin?
   end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save # => Validation
      # Sucess
      log_in @user
      flash[:success] = "新規登録が完了しました"
      redirect_to @user
      # GET "/users/#{@user.id}" => show
    else
      # Failure
      render 'new'      
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザー登録を削除しました"
    redirect_to users_url
   end
    def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
    end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:affiliation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end