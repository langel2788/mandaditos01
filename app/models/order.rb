class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :employee

def status_actual
    respuesta = "no tiene"
    case status
      when false then respuesta = "Pendiente"
      when true then respuesta = "Entregado"
    end
    respuesta    
end

end

