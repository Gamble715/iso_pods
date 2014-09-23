class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.integer :door_code

      t.timestamps
    end
  end
end
