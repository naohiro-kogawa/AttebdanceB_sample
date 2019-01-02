class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :edit_basic_info, :update_basic_info]
  
  def index
    @users = User.paginate(page: params[:page])
      if current_user.admin?
      else
         redirect_to(root_url) 
         flash[:warning] = "ほかのユーザにはアクセスできません"
      end
  end
   
   
  def show
    @user = User.find(params[:id])
  end
   
   
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "新規登録が完了しました"
        redirect_to user_url(current_user)
      else
        render 'new'      
      end
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash[:success] = "ユーザーのアカウント情報を変更しました"
         redirect_to user_path
      else
         render 'edit'
      end
  end
  
  
  def edit_basic_info
    @user = User.find(params[:id])
      if current_user.admin?
      else
         redirect_to(root_url) 
         flash[:warning] = "ほかのユーザにはアクセスできません"
      end
  end
  
  
  def update_basic_info
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash[:success] = "ユーザーの基本情報を更新しました。"
         redirect_to user_path
      else
         render 'edit'
      end
  end
  
  
  def destroy
    User.find(params[:id]).destroy
      flash[:success] = "ユーザー登録を削除しました"
        redirect_to users_url
  end
  
   
private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, 
      :affiliation,:specified_work_time, :basic_work_time)
    end
    
    def correct_user
      @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end