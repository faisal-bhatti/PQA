class AddCreatorIdAndToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :creator_id, :integer
  end

  def self.down
    remove_column :projects, :creator_id
  end
end
