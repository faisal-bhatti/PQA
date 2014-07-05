class ChangeField < ActiveRecord::Migration
  def change
  	remove_column :users, :phone
    add_column :users, :phone, :string
  end
end