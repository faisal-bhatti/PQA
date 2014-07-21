class TasksController < ApplicationController
  before_filter :require_login, :only => [:index]
  before_filter :load_project, :only => [:index, :show, :new, :create ]

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
    @project = Project.find(@task.project_id)
    d = User.find_all_by_user_type("developer")
    @developers = d && d.map { |a| [a.email, a.id] }
  end
   
  def create
    @task = @project.tasks.build(params[:task])
    @task.creator_id = current_user.id
    if @task.save
      
      user = User.find(params[:task][:developer_id])
      project = Project.find(@task.project_id)
      #  send email code here --------------------------------------
        m = Mandrill::API.new("5mdS2TEsBMC7kDh6vy3bQQ")
        message = {
          :subject=> "Task assign to you.",
          :from_name=>"PQA Administration.",
          :from_email=>"info@pqa.com",
          :to=>[{:email=>user.email}],
          :html=>"Dear #{user.name} <br/>
                  Task assign to you by the project manager.Details are given below<br/>
                  =================================================<br/><br/><strong>Project:</strong>#{project.name}<br/><strong>Task:</strong>#{@task.title}
                  <br/><strong>Description:</strong>#{@task.description}"
        }
        sending = m.messages.send message
        # alerts_by_sms(0)      # user.phone   call a member method
      flash[:notice] = 'Task was successfully created and emailed to assignee.'
      redirect_to(project_path(@project))
    else
      # render :action => "new"
      redirect_to root_url
    end
  end

  def alerts_by_sms(phone)
    require 'twilio-ruby'
    account_sid = 'AC34c808c17d7dfe7825c42e0960b99b0b'
    auth_token = 'c370859be7d064d385d6751bf5070daa'
    @client = Twilio::REST::Client.new account_sid, auth_token

    sms = @client.account.sms.messages.create(:body => "All in the game, yo",
      :to => "+923324167729",
      :from => "+19896071492")
  end


  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      # send email code here -----------------------------------------
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
