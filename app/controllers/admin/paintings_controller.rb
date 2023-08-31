class Admin::PaintingsController < ApplicationController
  before_action :is_admin?, only: [:edit, :update, :destroy]
  def new
    @painting = Painting.new
  end
  def create
    @painting = Painting.new(painting_params)
    @painting.user_id = current_user.id
    if @painting.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to painting_path(@painting.id)
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
  end
  
  def edit
    @painting = Painting.find(params[:id])
  end

  def update
    @painting = Painting.find(params[:id])
    if @painting.update(painting_params)
      redirect_to admin_painting_path(@painting), notice: "You have updated painting successfully."
    else
      render "edit"
    end
  end
  

  def index
    @paintings = Painting.page(params[:page])
  end

  def show
    @painting = Painting.find(params[:id])
    @painting_comment = PaintingComment.new
  end

  def destroy
    painting = Painting.find(params[:id])
    painting.destroy
    redirect_to admin_user_path(painting.user.id)
  end

    # 投稿データのストロングパラメータ
  private

  def painting_params
    params.require(:painting).permit(:title, :image, :caption, :is_opened, :user_id)
  end
  # 管理者でない場合はルートパスに返すメソッド
  def is_admin?
    unless admin_signed_in?
      redirect_to root_path
    end
  end


end
