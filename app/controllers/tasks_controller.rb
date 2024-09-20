class TasksController < ApplicationController
  # before_action to find task by id for the specified actions (show, edit, update, destroy)
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # loads all tasks and assigns them to @tasks
    @tasks = Task.all
  end

  def show
    # @task is already set by the before_action
  end

  def new
    # initializes a new task for the form
    @task = Task.new
  end

  def create
    # creates a new task with the allowed parameters
    @task = Task.new(task_params)
    if @task.save
      # if task is successfully saved, redirects to the tasks list
      redirect_to tasks_path
    else
      # if validation fails, re-renders the new form
      render :new
    end
  end

  def edit
    # @task is already set by the before_action
  end

  def update
    # updates the task with the allowed parameters
    if @task.update(task_params)
      # if update is successful, redirects to the task details
      redirect_to task_path(@task)
    else
      # if update fails, re-renders the edit form
      render :edit
    end
  end

  def destroy
    # deletes the task and redirects to the tasks list with see_other status
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  # sets the task based on the id passed in params
  def set_task
    @task = Task.find(params[:id])
  end

  # strong parameters to allow only title, details, and completed fields
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
