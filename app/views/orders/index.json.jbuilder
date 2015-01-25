json.array!(@orders) do |order|
  json.extract! order, :id, :costo, :colonia, :hora_registro, :hora_entrega, :status, :detalles, :user_id, :employee_id
  json.url order_url(order, format: :json)
end
