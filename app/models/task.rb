class Task < ActiveRecord::Base
  # attr_accessible :remote_image_url, :status, :title, :task_type, :user_id, :assigned_to, :project_id, :description, :creator_id, :developer_id
  attr_protected
  belongs_to :creator, :class_name => "User"
  belongs_to :developer, :class_name => "User"
  belongs_to :project

  mount_uploader :image, ImageUploader

  #TODO move these array to /config/intializer/constants.rb
  def task_types_list
    task_types = ['Bug', 'Fearure']
  end

  def task_status_list
    task_types = ['New', 'Started', 'Resolved']
  end


end
