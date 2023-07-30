class Public::HomesController < ApplicationController
  def top
    @paintings = Painting.page(params[:page])
  end

  def about
  end
end
