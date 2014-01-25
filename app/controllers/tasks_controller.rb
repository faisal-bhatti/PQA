class TasksController < ApplicationController
  before_filter :require_login, :only => [:index]
  before_filter :load_project, :only => [:index, :edit, :show, :new, :create ]

  def show
    @task = Task.find(params[:id])
  end

  def new_user_task
    @task = current_user.tasks_creator.build
    d = User.find_all_by_user_type("developer")
    p = Project.all
    @developers = d && d.map { |a| [a.email, a.id] }
    @projects = p && p.map { |a| [a.name, a.id] }
  end

  def user_create_task
    @task = current_user.tasks_creator.build(params[:task])
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to(created_bugs_user_path(current_user))
    else
      render :action => "new_user_task"
    end  
  end

  def new
    @task = @project.tasks.build
    d = User.find_all_by_user_type("developer")
    @developers = d && d.map { |a| [a.email, a.id] }
  end

  def edit
    @task = Task.find(params[:id])
    d = User.find_all_by_user_type("developer")
    @developers = d && d.map { |a| [a.email, a.id] }
  end

  def create
    @task = @project.tasks.build(params[:task])
    @task.creator_id = current_user.id
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to(project_path(@project))
    else
      render :action => "new"
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task was successfully updated.'
      @project = @task.project
      redirect_to @project
    else
      render :action => "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = 'Task was successfully deleted.'
      redirect_to :back
    else
      render :action => "edit"
    end
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
  end


end
