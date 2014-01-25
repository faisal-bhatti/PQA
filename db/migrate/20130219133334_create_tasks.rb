class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :image
      t.string :status
      t.string :type

      t.timestamps
    end
  end
end
