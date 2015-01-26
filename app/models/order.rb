class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :employee

def status_actual
    respuesta = "no tiene"
    case status
      when 0 then respuesta = "Pendiente"
      when 1 then respuesta = "Entregado"
      when 2 then respuesta = "Cancelado"
    end
    respuesta    
end

def repartidor_asignado
	respuesta = "No esta asignado"
	if employee != nil
		respuesta = employee.nombre
	end
	respuesta
end

end

