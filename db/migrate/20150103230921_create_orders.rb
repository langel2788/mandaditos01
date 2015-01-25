class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :costo, precision: 4, scale: 2
      t.string :colonia
      t.datetime :hora_registro
      t.datetime :hora_entrega
      t.boolean :status
      t.text :detalles
      t.references :user, index: true
      t.references :employee, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :employees
  end
end
