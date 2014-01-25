class UsersController < ApplicationController
  before_filter :require_login, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    #return render :json => @user
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end


  def created_bugs
    @user = User.find(params[:id])
    @tasks = @user.tasks_creator
  end

  def developed_bugs
    @user = User.find(params[:id])
    @tasks = @user.tasks_developer
  end

end