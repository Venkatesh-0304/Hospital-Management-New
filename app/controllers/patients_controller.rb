class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit destroy update]
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def show
  end

  def edit
  end

  def create
    @patient = Patient.new(params_patient)

    if @patient.save
      redirect_to patients_path, notice: "Patient #{@patient.name} created successfully"
    else
      render :new, status: :unprocessable_entity
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
    debugger
    params.require(:patient).permit(:name, :age, :gender, :born_on)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
