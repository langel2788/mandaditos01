# TUTORIAL MANDADITOS

rails g migration add_cliente_to_users cliente:string
#app/views/admin/users/edit agregar el campo cliente
<div class="form-group">
      <%= f.label :email %>
      <div class="row">
        <div class="col-sm-6">      
          <%= f.email_field :email, class: "form-control" %>  
        </div>
      </div>
    </div>
#app/controllers/admin/users_controller 
def update
	....
	....
    @user.cliente = new_params[:cliente]

end
# agregar los parametros que se pueden modificar en app/controllers/admin/users_controller 
def user_params
    params.require(:user).permit(
    :username,
    :cliente,
    ......

    )
  end


#app/views/admin/users/index agregar el campo cliente en la lista completa
<table class="table table-striped">
  <tr>
    <th>User ID</th>
    <th>Username</th>
    <th>Cliente</th>

.....



rails g migration add_costo_de_entrega_to_users costo_de_entrega:decimal{4.2}

rails g migration add_telefono_to_users telefono:string

rails g migration add_direccion_to_users direccion:string

rails g migration add_detalles_to_users detalles:text

rails g migration add_contrato_to_users contrato:decimal{4.2}

git status
git add .
git commit -am "modelo usuario completo"
git push origin master

git checkout -b modelo_empleado

rails g scaffold Employee nombre:string sueldo:decimal{5.2} bono:decimal{5.2} dia_descanso:string status:integer

# Agregar en index de empleados
        <td><%= link_to ' Dar de Baja', dar_de_baja_employee_path(employee,employee.id), method: :patch, data: { confirm: 'Estas seguro?' } %></td>
        <td><%= link_to ' Reactivar', dar_de_alta_employee_path(employee,employee.id), method: :patch, data: { confirm: 'Estas seguro?' } %></td>
# Agregar en routes 
  resources :employees do
    member do |variable|
      patch :dar_de_baja    
      patch :dar_de_alta
    end
  end

  # Agregar en modelo de empleados la funcion status actual
  
  # agregar las nuevas funciones en before action en controlador de empleados
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :dar_de_baja, :dar_de_alta]

# agregar los parametros que se pueden modificar en app/controllers/admin/employee_controller 
def user_params
    params.require(:employee).permit(:nombre, :sueldo, :bono, :dia_descanso, :status)

  end

 # agregar las funciones de alta y baja de epmpleados en controlador de empleados
  def dar_de_baja
    @employee.update_attribute(:status,1)
    redirect_to @employee, notice: "Empleado dado de baja"
  end

  def dar_de_alta
    @employee.update_attribute(:status,0)
    redirect_to @employee, notice: "Empleado Reactivado"
  end

  # modificar el archivo de la barra de navegacion en app/layouts/_navigation_links.html.erb y _navigation
  <li><%= link_to "Publicaciones", posts_path %></li>
<li><%= link_to "Contacto", contact_path %></li>
<% if !user_signed_in? %>
	<li><%= link_to "Sign in", new_user_session_path %></li>

<% else %>
	<li><%= link_to "Protected Page", inside_path %></li>

<% if current_user.admin? %>
	<li><%= link_to "Empleados", employees_path %></li>
	<li><%= link_to "Admin", admin_root_path %></li>

.....
.....


rails g scaffold Order costo:decimal{4.2} colonia:string hora_registro:datetime hora_entrega:datetime status:boolean detalles:text user:references employee:references

# agregar el link de lso pedidos a la barra de navegacion
# en app/layouts/_navigation_links.html.erb
<% else %>
	<li><%= link_to "Protected Page", inside_path %></li>
	<li><%= link_to "Pedidos", orders_path %></li>


# modificar el new de orders para solo dejar los campos colonia y detalles, los demas son datos automaticos
  <div class="field">
    <%= f.label :colonia %><br>
    <%= f.text_field :colonia %>
  </div>


  <div class="field">
    <%= f.label :detalles %><br>
    <%= f.text_area :detalles %>
  </div>



  <div class="actions">
    <%= f.submit %>
  </div>

  ......

# modificar el index de pedidos para mostrsar las relaciones con user y employee
    .....
    <td><%= order.user.username %></td>
    <td><%= order.employee.nombre %></td>
	.....
# modificar el show de pedidos para mostrsar las relaciones con user y employee

#En el form de employees agrego la opcion para seleccionar el dia de la seman de descanso
  <div class="field">
    <%= f.label :dia_descanso %> <br>
    <%= f.select(:dia_descanso,[
      ['Lunes', "Monday"], 
      ['Martes', "Tuesday"], 
      ['Miercoles', "Wednesday"], 
      ['Jueves', "Thursday"], 
      ['Viernes', "Friday"],
      ['Sabado', "Saturday"],
      ['Domingo', "Sunday"]
    ]) %>

  </div>

# en el form de employees agrego la opcion para que el stats sea con radio button

<%= f.label :status %><br>
  <div class="field">
    <%= f.label :status do %> 
      <%= f.radio_button(:status,"0") %> 
        Activo 
    <% end %>

    <%= f.label :status do %> 
      <%= f.radio_button(:status,"1") %> 
        Baja 
    <% end %>



#en el controlador orders se agrega la funcion para cambiar de status a entregado
# se actualiza la fecha y hora para llevar registro de los tiempos
  def cambiar_a_entregado
    @order.update_attribute(:status,1)
    @order.update_attribute(:hora_entrega,DateTime.now)

    redirect_to @order, notice: "Pedido entregado"
  end

# en el controlador order se agrega la nueva funcion para que se pueda ejecutar
  before_action :set_order, only: [:show, :edit, ...... :cambiar_a_entregado]

# en el archivo routes se agrega la ruta a la funcion de cambiar el status a entregado para que genere la ruta
# automaticamente
resources :orders do 
    member do |variable|
      patch :cambiar_a_entregado    
    end
    
  end

# del index de orders se quitan los campos que se deben registrar automaticamente por sistema o que se modificaran
#a travez de una funcion especifica

    <%= f.label :hora_registro %>
    <%= f.datetime_select :hora_registro %>
    <%= f.datetime_select :hora_entrega %>
    <%= f.text_field :status %>
    <%= f.text_field :user_id %>
    <%= f.text_field :employee_id 
    <%= f.text_field :costo %>
 
 # cambiar el tipo de dato del campo status de orders para poder agregar el status cancelado y no solo boleano
  rails g migration change_status_format_in_orders
  change_column(:orders, :status, :integer)




#en el controlador orders se agrega la funcion para cambiar de status a cancelado
# se actualiza la fecha a nulo por que siginifica que no se entrego
  def cancelar_pedido
    @order.update_attribute(:status,2)
    @order.update_attribute(:hora_entrega,nil)

    redirect_to @order, notice: "Pedido Cancelado"
  end

# en el controlador order se agrega la nueva funcion para que se pueda ejecutar
  before_action :set_order, only: [:show, :edit, ...... :cancelar_pedido]

# en el archivo routes se agrega la ruta a la funcion de cambiar el status a cancelado para que genere la ruta
# automaticamente
resources :orders do 
    member do |variable|
      patch :cambiar_a_entregado    
      patch :cancelar_pedido
    end
    
  end


# En la _form de orders se agrega la opcion de seleccionar al repartidor

<div class="field">
    <%= f.label(:employee_id, "Repartidor") %><br>
    <%= f.select(:employee_id, Employee.all.collect {|p| [ p.nombre, p.id ] }, {include_blank: 'Ninguno'}) %>
  </div>

# En la _form de orders se cambia el orden de los datos y se modifican los links para seleccionar la direccion como
# el link para consultar el registro

  <tbody>
    <% @orders.each do |order| %>
      <tr>
        <td><%= order.user.cliente %></td>
        <td><%= link_to order.colonia,order %></td>
        <td><%= link_to order.costo, order %></td>        
        <td><%= order.hora_registro %></td>
        <td><%= order.hora_entrega %></td>
        <td><%= order.status_actual %></td>
        <td><%= order.detalles %></td>
        
        <td><%= order.employee.nombre %></td>
        <td><%#= link_to 'Editar', edit_order_path(order) %></td>
        <td><%#= link_to 'Destroy', order, method: :delete, data: { confirm: 'Estas seguro?' } %></td>
        <td><%= link_to 'Cancelar', cancelar_pedido_order_path(order,order.id), method: :patch, data: { confirm: 'Estas seguro?' } %></td>
        <td><%= link_to 'Registrar Entrega', cambiar_a_entregado_order_path(order,order.id), method: :patch, data: { confirm: 'Estas seguro?' } %></td>
      </tr>

#se crea funcion en 


# REGSITRAR KILIMEREAJE Y GASOLINA DE LAS MOTOS Y LA CAJA CHICA


# REGISTRAR NUMERO DE COMANDAS, YA ESTAN IMPRERSAS DE IMPRENTA



