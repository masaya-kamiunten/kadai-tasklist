class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が作成されませんでした'
      render :new
    end
  end
  
  def index
    @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
  end
  
  def show
    set_task
  end
  
  def new
    @task = Task.new
  end
  
  def edit
    set_task
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content)
  end
end
