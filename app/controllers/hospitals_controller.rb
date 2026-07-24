class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[show edit destroy update doctors]
  def index
    @hospitals = Hospital.page(params[:page]).per(20)
  end

  def new
    @hospital = Hospital.new
  end

  def doctors
  end

  def show
    @last_hospital = Hospital.find_by(id: cookies[:last_viewed_hospital_id])
    cookies.permanent[:last_viewed_hospital_id] = @hospital.id
  end

  def edit
  end

  def create
    @hospital = Hospital.new(params_hospital)
    respond_to do |format|
      if @hospital.save
        @hospitals_count = Hospital.count
        format.turbo_stream
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @hospital.update(params_hospital)
        HospitalMailer.details_updated(@hospital).deliver_now
        format.turbo_stream
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @hospital.destroy
      @hospitals_count = Hospital.count
      respond_to do |format|
        format.turbo_stream
      end
    else
      redirect_to hospitals_path, notice: "Hospital not found"
    end
  end

  private

  def params_hospital
    params.require(:hospital).permit(:name, :admin_email, :address)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
