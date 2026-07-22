class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show edit update destroy ]
  # before_action :check_access
  def index
    @doctors = Doctor.all
    # render json: {
    #   "message": "Doctor not found"
    # }, status: :not_found
    # head :no_content
    # render plain: "Hello", status: :no_content
    # redirect_to patients_path
    # puts "2. Inside the index action"
    # render plain: "Hello"
    # puts "Method       : #{request.method}"
    # puts "Path         : #{request.path}"
    # puts "Fullpath     : #{request.fullpath}"
    # puts "Host         : #{request.host}"
    # puts "Remote IP    : #{request.remote_ip}"
    # puts "Accept headres"
    # puts request.headers["Accept"]
    # puts
    # puts "Request format"
    # puts request.format
    # render plain: "Done"
    # puts "Accepted Headers : #{request.headers["Accept"]}"
    # puts "Request Format   : #{request.format}"
    # pp params
    # session[:count] ||= 0
    # session[:count] += 1
    # render plain: "Visits: #{session[:count]}"
    # flash[:notice] = "Welcome to Doctors"
    # render plain: flash[:notice]
  end
  def search
    @doctors = Doctor.where("name ILIKE :q", q: "%#{params[:q]}%")
    render json: @doctors
  end

  def new
    @doctor = Doctor.new
    @doctor.build_profile
  end

  def show
  end

  def edit
  end

  def create
    @doctor = Doctor.new(doctor_params)

    # render plain: "Doctor Created"
    respond_to do |format|
      if @doctor.save
        format.turbo_stream
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.turbo_stream
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_path, notice: "Doctor deleted successfully"
  end

  private
  def doctor_params
    # params.require(:doctor).permit(:name, :specialization, :hospital_id, profile_attributes: [ :experience, :consultation_fee ])
    result = params.require(:doctor).permit(:name, :specialization, :hospital_id, profile_attributes: [ :experience, :consultation_fee ])
    pp result
    puts "Permitted #{result.permitted?}"
    result
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  # def check_access
  #   puts "1. Inside the before action"
  #   render plain: "Access denied", status: :forbidden
  # end
end
