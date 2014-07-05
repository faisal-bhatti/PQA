class AddPhoneNoToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :number
  end
end
