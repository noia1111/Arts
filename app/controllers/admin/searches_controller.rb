class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == 'クリエイター検索'
      @users = User.looks(params[:word])
    else
      @paintings = Painting.looks(params[:word]).page(params[:page])
    end
  end
end