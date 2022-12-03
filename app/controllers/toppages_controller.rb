class ToppagesController < ApplicationController
  def index
    if logged_in?
      @cookinglist = current_user.cookinglists.build  # form_with 用
      @pagy, @cookinglists = pagy(current_user.cookinglists.order(id: :desc))
    end
  end
end
