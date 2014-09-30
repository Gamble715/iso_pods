class AddCustomerIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :customer_id, :string
  end
end
