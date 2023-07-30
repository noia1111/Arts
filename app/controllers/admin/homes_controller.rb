class Admin::HomesController < ApplicationController
  def top
    is_admin?
    @paintings = Painting.page(params[:page])
  end

  def about
  end
  
  def is_admin?
    unless admin_signed_in?
      redirect_to root_path
    end
  end
end
