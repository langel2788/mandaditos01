class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :dar_de_baja, :dar_de_alta,:suspender]

  respond_to :html

  def index
    @employees = Employee.all
    respond_with(@employees)
  end

  def show
    respond_with(@employee)
  end

  def new
    @employee = Employee.new
    respond_with(@employee)
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.save
    respond_with(@employee)
  end

  def update
    @employee.update(employee_params)
    respond_with(@employee)
  end

  def destroy
    @employee.destroy
    respond_with(@employee)
  end

  def dar_de_baja
    @employee.update_attribute(:status,1)
    redirect_to @employee, notice: "Empleado dado de baja"
  end

  def dar_de_alta
    @employee.update_attribute(:status,0)
    redirect_to @employee, notice: "Empleado Reactivado"
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:nombre, :sueldo, :bono, :dia_descanso, :status)
    end
end
