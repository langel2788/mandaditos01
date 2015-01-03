class AddCostoDeEntregaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :costo_de_entrega, :decimal, :precision=>4, :scale=>2 
  end
end
