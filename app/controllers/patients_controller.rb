class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit destroy update]
  def index
    @patients = Patient.all
  end

  def search
    @patients = Patient.where("name ILIKE :q", q: "%#{params[:q]}%")
    render json: @patients
  end

  def new
    @patient = Patient.new
  end

  def show
  end

  def edit
  end

  def export
    @patients = Patient.all

    csv_data = CSV.generate do |csv|
      csv << [ "name", "age", "gender", "Date of Birth" ]
      @patients.each do |patient|
        csv << [ patient.name, patient.age, patient.gender, patient.born_on ]
      end
    end

    send_data csv_data,
      filename: "patients_#{Date.today}.csv",
      type: "text/csv",
      disposition: "attachment"
  end

  def create
    @patient = Patient.new(params_patient)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patients_path, notice: "Patient created successfully." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "patient_form",
            partial: "patients/form",
            locals: { patient: @patient }
          )
        end
      end
    end
  end
  def update
    if @patient.update(params_patient)
      redirect_to patients_path, notice: "Patient #{@patient.name} updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient deleted successfully"
  end

  private

  def params_patient
    params.require(:patient).permit(:name, :age, :gender, :born_on, :phone)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
