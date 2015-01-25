json.array!(@employees) do |employee|
  json.extract! employee, :id, :nombre, :sueldo, :bono, :dia_descanso, :status
  json.url employee_url(employee, format: :json)
end
