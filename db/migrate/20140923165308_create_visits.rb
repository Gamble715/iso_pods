class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user, index: true
      t.references :pod, index: true

      t.timestamps
    end
  end
end
