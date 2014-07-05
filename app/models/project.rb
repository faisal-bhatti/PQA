class Project < ActiveRecord::Base

  attr_accessible :description, :name, :owner

  belongs_to :user
  has_many :tasks, dependent: :destroy

  has_many :user_projects
  has_many :users, :through => :user_projects

  validates :name, :presence => true
  validates_uniqueness_of :name

end