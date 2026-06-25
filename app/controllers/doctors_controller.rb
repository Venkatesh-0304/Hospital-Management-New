class DoctorsController < ApplicationController
  layout "doctor"
  before_action :set_doctor, only: %i[show edit update destroy ]
  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def show
  end

  def edit
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      redirect_to doctors_path, notice: "Doctor #{@doctor.name} added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to doctors_path, notice: "Doctor #{@doctor.name} updated successfully"
    else
      render :edit, status: :unprocessabel_entity
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_path, notice: "Doctor deleted successfully"
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
