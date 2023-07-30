class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @painting = Painting.find(params[:painting_id])
    favorite = current_user.favorites.new(painting_id: @painting.id)
    favorite.save
  end

  def destroy
    @painting = Painting.find(params[:painting_id])
    favorite = current_user.favorites.find_by(painting_id: @painting.id)
    favorite.destroy
  end

end
