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



rails g migration add_costo_de_entrega_to_users costo_de_entrega:decimal{4,2}

rails g migration add_telefono_to_users telefono:string

rails g migration add_direccion_to_users direccion:string

rails g migration add_detalles_to_users detalles:text

rails g migration add_contrato_to_users contrato:decimal{4.2}