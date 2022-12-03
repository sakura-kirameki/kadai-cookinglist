class TodosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @todo = current_user.todos.build  # form_with 用
      @pagy, @todos = pagy(current_user.todos.order(id: :desc))
    end
  end
  
  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:success] = '買うものリストを登録しました。'
      redirect_to todos_path
    else
      @pagy, @todos = pagy(current_user.todos.order(id: :desc))
      flash.now[:danger] = '買うものリストの登録に失敗しました。'
      render 'todos/index'
    end
  end

  def destroy
    @todo.destroy
    flash[:success] = '買うものリストを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def todo_params
    params.require(:todo).permit(:content)
  end
  
  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
    unless @todo
      redirect_to root_url
    end
  end
    
end
