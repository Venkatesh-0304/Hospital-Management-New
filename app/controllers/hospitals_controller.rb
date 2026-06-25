class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[show edit destroy]
  def index
    @hospitals = Hospital.all
  end

  def new
    @hospital = Hospital.new
  end

  def show
  end

  def edit
  end

  def create
    @hospital = Hospital.new(params_hospital)

    if @hospital.save
      redirect_to hospitals_path, notice: "Hospital #{@hospital.name} added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @hospital.update(params_hospital)
      redirect_to hospitals_path, notice: "Hospital #{@hospital.name} added successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hospital.destroy

    redirect_to hospitals_path, notice: "Hospital #{@hospital.name} deleted successfully"
  end

  private

  def params_hospital
    params.require(:hospital).permit(:name)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
