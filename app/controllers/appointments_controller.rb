class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit destroy update]
  def index
    @appointments = Appointment.all
  end

  def edit
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(params_appointment)

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(params_appointment)
      redirect_to appointments_path, notice: "Updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully"
  end

  private

  def params_appointment
    debugger
    params.require(:appointment).permit(:reason, :doctor_id, :patient_id, :appointment_date)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
