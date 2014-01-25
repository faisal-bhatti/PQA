class ProjectsController < ApplicationController
  before_filter :require_login, :only => [:index]

  def index
      @projects = Project.all
      if current_user.user_type == "manager"
        @users = User.all
        @tasks = Task.all
      end

  end

  def edit
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new

  end

  def show
    @project = Project.find(params[:id])
    if current_user
      if current_user.user_type == "Manager"
        @tasks = @project.tasks
      else
        @tasks_to_me = Task.find_all_by_project_id_and_developer_id(@project.id, current_user.id)
        @tasks_by_me = Task.find_all_by_project_id_and_creator_id(@project.id, current_user.id)
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project was successfully updated.'
      redirect_to project_path
    else
      render :action => "edit"
    end
    end

  def destroy
    @project = Project.find(params[:id])

    if @project.destroy
      flash[:notice] = 'Project was successfully destroy.'
      redirect_to projects_path
    else
      render :action => "index"
    end
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = 'Project was successfully created.'
      redirect_to(projects_path)
    else
      render :action => "new"
    end
  end
end