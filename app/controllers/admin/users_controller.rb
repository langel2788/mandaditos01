class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @users = User.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_user_path(params[:id])
  end
  
  def edit
  end
  
  def update
    old_username = @user.username
    new_params = user_params.dup
    new_params[:username] = new_params[:username].strip
    new_params[:email] = new_params[:email].strip
    
    @user.username = new_params[:username]
    #agregago por mi
    @user.cliente = new_params[:cliente]
    @user.costo_de_entrega = new_params[:costo_de_entrega]
    @user.contrato = new_params[:contrato]
    @user.telefono = new_params[:telefono]
    @user.direccion = new_params[:direccion]
    @user.detalles = new_params[:detalles]
    

    @user.email = new_params[:email]
    @user.password = new_params[:password] if new_params[:password].strip.length > 0
    @user.password_confirmation = new_params[:password_confirmation] if new_params[:password_confirmation].strip.length > 0
    
    if current_user.id != @user.id
      @user.admin = new_params[:admin]=="0" ? false : true
      @user.locked = new_params[:locked]=="0" ? false : true
    end
    
    if @user.valid?
      @user.skip_reconfirmation!
      @user.save
      redirect_to admin_users_path, notice: "#{@user.username} Actualizado."
    else
      flash[:alert] = "#{old_username} No se pudo actualizar."
      render :edit
    end
  end
  
  
  private 
  
  def set_user
    @user = User.friendly.find(params[:id])
  rescue
    flash[:alert] = "El usuario con el id #{params[:id]} no existe."
    redirect_to admin_users_path
  end
  
  def user_params
    params.require(:user).permit(
    :username,
    # agregago por mi
    :cliente,
    :costo_de_entrega,
    :contrato,
    :telefono,
    :direccion,
    :detalles,
    :email,
    :password,
    :password_confirmation,
    :admin,
    :locked
    )
  end
  
end
