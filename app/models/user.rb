class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tasks_creator, :class_name => "Task", :foreign_key => "creator_id"
  has_many :tasks_developer, :class_name => "Task", :foreign_key => "developer_id"

  has_many :user_projects
  has_many :projects, :through => :user_projects

  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :user_type,:phone, :name
  attr_accessor :password_confirmation
  validates :password, :presence => true
  #validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  validates :name, :presence => true
  validates :phone, :presence => true

  validates :email, :presence => true


  #TODO move to constants.rb
  def u_types
    u_types = ['Manager', 'QA', 'Developer']
  end

end
