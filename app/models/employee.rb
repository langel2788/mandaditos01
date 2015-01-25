class Employee < ActiveRecord::Base
has_many :orders
def status_actual
    respuesta = "sin status"
    case status
      when 0 then respuesta = "Activo"
      when 1 then respuesta = "Baja"
    end
    respuesta    
end


end
