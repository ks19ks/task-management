class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks

    if params[:sort_due]
      @tasks = @tasks.order('due_date DESC NULLS LAST, created_at DESC')
    elsif params[:sort_priority]
      @tasks = @tasks.order('priority NULLS LAST, created_at DESC')
    else
      @tasks = @tasks.order(created_at: :DESC)
    end

    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.search_by_title(params[:task][:title]).search_by_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.search_by_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.search_by_status(params[:task][:status])
      end
    end

    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: t('tasks.create_notice')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('tasks.update_notice')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('tasks.destroy_notice')
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :priority)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
