class ChangeStatusFormatInOrders < ActiveRecord::Migration
  def change
  	change_column(:orders, :status, :integer)
  end
end
