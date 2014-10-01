class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
