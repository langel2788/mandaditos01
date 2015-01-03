class AddClienteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cliente, :string
  end
end
