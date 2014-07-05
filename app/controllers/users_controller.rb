class UsersController < ApplicationController
  before_filter :require_login, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    #return render :json => @user
    if @user.save
      m = Mandrill::API.new("5mdS2TEsBMC7kDh6vy3bQQ")
      message = {
        :subject=> "Welcome to visit our site.",
        :from_name=>"PQA Administration.",
        :from_email=>"info@pqa.com",
        :to=>[{:email=>@user.email}],
        :html=>"Welcome to PQA, #{@user.name} <br/>
                  ===============================================
                  <br/><br/>
                  Whenever you have to assign to any project/task, we will inform to you by an email. So please be in touch.<br/>
                  your Email is:  #{@user.email} 
                  
                  <br/><br/>
                  Thanks for joining and have a great day!"
      }
      sending = m.messages.send message
      puts "----------------"
      puts sending.inspect
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
    
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    flash[:success] = "successfully updated."
    redirect_to root_url
  end
  
  def created_bugs
    @user = User.find(params[:id])
    @tasks = @user.tasks_creator
  end

  def developed_bugs
    @user = User.find(params[:id])
    @tasks = @user.tasks_developer
  end

  def destroy
    user = User.find(params[:id])
    tasks = Task.where(developer_id: user.id)
    tasks && tasks.each do |task|
      task.developer_id = nil
      task.save!
    end
    user.destroy
    flash[:success] = "successfully destroyed."
    redirect_to root_url
  end
end