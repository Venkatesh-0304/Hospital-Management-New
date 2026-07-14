module Api
  module V1
    class AppointmentsController < ActionController::API
      before_action :set_appointment, only: %i[show update destroy cancel]

      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

      def index
        @patient = Patient.find(params[:patient_id])
        @appointments = @patient.appointments
        render json: @appointments
      end

      def show
        render json: @appointment
      end

      def create
        @patient = Patient.find(params[:patient_id])
        @appointment = @patient.appointments.build(appointment_params)

        if @appointment.save
          render json: @appointment, status: :created, location: api_v1_appointment_path(@appointment)
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @appointment.update(appointment_params)
          render json: @appointment
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @appointment.destroy!
        render json: { message: "Appointment deleted" }, status: :no_content
      end

      def cancel
        if @appointment.update(status: :cancelled)
          render json: @appointment
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def upcoming
        @appointments = Appointment.where("appointment_time > ?", Time.current).order(:appointment_time)
        render json: @appointments
      end

      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def appointment_params
        params.require(:appointment).permit(:patient_id, :doctor_id, :appointment_time, :reason, :status)
      end

      def render_not_found(exception)
        render json: { error: "Appointment not found" }, status: :not_found
      end

      def render_validation_error(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
