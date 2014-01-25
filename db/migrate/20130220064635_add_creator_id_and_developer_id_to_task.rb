class AddCreatorIdAndDeveloperIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :creator_id, :integer
    add_column :tasks, :developer_id, :integer
  end
  def self.down
    remove_column :tasks, :creator_id
    remove_column :tasks, :developer_id
  end
end
