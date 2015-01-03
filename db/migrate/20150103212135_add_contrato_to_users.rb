class AddContratoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contrato, :decimal, precision: 4, scale: 2
  end
end
