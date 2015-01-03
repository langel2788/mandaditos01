class AddDetallesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :detalles, :text
  end
end
