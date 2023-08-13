class Admin::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @paintings = @user.paintings.page(params[:page])
  end

  def edit
    is_admin?
    @user = User.find(params[:id])
  end

  def update
    is_admin?
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to  admin_user_path(user.id)
    else
      render :edit
    end
  end
  
  def index
    @users = User.all
  end
  
  def check
    is_admin?
  end

  def withdraw
    is_admin?
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  # いいね一覧機能
  before_action :set_user, only: [:favorites]
  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:painting_id)
    @favorite_paintings = Painting.where(id: favorites).page(params[:page])
  end



  private
  def set_user
    @user = User.find(params[:id])
  end
    # 管理者でない場合はルートパスに返すメソッド
  def is_admin?
    unless admin_signed_in?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name,:introduction, :is_male, :age, :header_image, :icon_image ,:is_deleted)
  end
end
