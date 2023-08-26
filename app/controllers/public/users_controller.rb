class Public::UsersController < ApplicationController
  before_action :is_matching, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @paintings = @user.paintings.page(params[:page])
    if @user.is_deleted == true
      flash[:notice] = "このユーザーは退会済です"
      redirect_to root_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to  user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def index
    @users = User.select('users.*, COUNT(favorites.id) AS total_favorites')
                 .joins(paintings: :favorites)
                 .group('users.id')
                 .order('total_favorites DESC')
  end
  
  def check
  end

  def withdraw
    @user = current_user
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
  
  def is_matching
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name,:introduction, :is_male, :age, :header_image, :icon_image ,:is_deleted)
  end
end
