class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :asignar_repartidor, :cambiar_a_entregado,:cancelar_pedido]

  respond_to :html

  def index
    if current_user.username =='admin'
      @orders = Order.all
    else
      # @orders = Order.all
      @orders = Order.where(user_id: current_user.id)
                # Person.where(name: 'Spartacus', rating: 4)
    end
    respond_with(@orders)

  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    respond_with(@order)
  end

  def new_by_admin
    @order = Order.new
    respond_with(@order)
  end
    
  def edit
  end

  def create
    @order = Order.new(order_params)
    
    @order.status = false

    @order.hora_registro = DateTime.now

#    @order.user_id = current_user.id
    
    # validar quien es el usuario actual para asignar el costo del pedido
    if current_user.username != "admin"
      @order.user_id = current_user.id
      @order.costo = current_user.costo_de_entrega
    else
      @order.costo = @order.user.costo_de_entrega
    end

    @order.save
    respond_with(@order)
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  def cambiar_a_entregado
    @order.update_attribute(:status,1)
    @order.update_attribute(:hora_entrega,DateTime.now)

    redirect_to @order, notice: "Pedido entregado"

    #redirect_to orders_path, notice: "Pedido entregado"
    #redirect_to orders_path, notice: "Pedido de "+ @order.user.cliente + " Registado entregado a las "+ @order.hora_entrega.to_s
  end

  def cancelar_pedido
    @order.update_attribute(:status,2)
    @order.update_attribute(:hora_entrega,nil)

    # redirect_to @order, notice: "Pedido Cancelado"
    redirect_to orders_path, notice: "Pedido de #{@order.user.cliente} de las #{@order.hora_registro.to_s} Cancelado ."
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:costo, :colonia, :hora_registro, :hora_entrega, :detalles, :user_id, :employee_id, :status)
    end
end
