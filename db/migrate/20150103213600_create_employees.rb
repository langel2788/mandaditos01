class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :nombre
      t.decimal :sueldo, precision: 5, scale: 2
      t.decimal :bono, precision: 5, scale: 2
      t.string :dia_descanso
      t.integer :status

      t.timestamps null: false
    end
  end
end
