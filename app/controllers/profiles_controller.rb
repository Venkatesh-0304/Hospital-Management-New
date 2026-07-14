class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit destroy update]
  def index
    @profiles = Profile.all
  end

  def edit
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params_profile)

    if @profile.save
      redirect_to profiles_path, notice: "#{@profile.doctor.name} profile added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(params_profile)
      redirect_to profiles_path, notice: "#{@profile.doctor.name} profile updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice: "#{@profile.doctor.name} profile deleted successfully"
  end

  private

  def params_profile
    params.require(:profile).permit(:doctor_id, :experience, :consultation_fee, languages_spoken: [])
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
