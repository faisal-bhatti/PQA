class RenametypewithtasktypeToTask < ActiveRecord::Migration
  def up
  	remove_column :tasks, :type
  	add_column :tasks, :task_type, :string
  end

  def down
  	add_column :tasks, :type, :string
  	remove_column :tasks, :task_type
  end
end
