class CookinglistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @cookinglist = current_user.cookinglists.build(cookinglist_params)
    if @cookinglist.save
      flash[:success] = '料理を記録しました。'
      redirect_to root_url
    else
      @pagy, @cookinglists = pagy(current_user.cookinglists.order(id: :desc))
      flash.now[:danger] = '料理の記録に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @cookinglist.destroy
    flash[:success] = '料理の記録を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def cookinglist_params
    params.require(:cookinglist).permit(:content)
  end
  
  def correct_user
    @cookinglist = current_user.cookinglists.find_by(id: params[:id])
    unless @cookinglist
      redirect_to root_url
    end
  end
end
