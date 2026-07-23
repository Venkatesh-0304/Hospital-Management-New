class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit destroy update cancel]
  def index
    @appointments = Appointment.all
  end

  def cancel
    @appointment.update(status: "Cancelled")
    redirect_to appointments_path notice: "Appointment Cancelled"
  end

  def upcoming
    @appointments = Appointment.where("Scheduled_at > ?", Time.current)
    render json: @appointments
  end

  def edit
  end

  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html # renders app/views/appointments/show.html.erb
      format.json { render json: @appointment }
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(params_appointment)

    if @appointment.save
      # flash[:notice] = "Appointment added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(params_appointment)
      respond_to do |format|
        format.turbo_stream
      end
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
    params.require(:appointment).permit(:notes, :doctor_id, :patient_id, :scheduled_at)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
