class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[show edit destroy update doctors]
  def index
    @hospitals = Hospital.all
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
        format.turbo_stream
        format.html { redirect_to hospitals_path, notice: "#{@hospital.name} successfully created" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@hospital, :form),
            partial: "form",
            locals: { hospital: @hospital }
          ), status: :unprocessable_entity
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @hospital.update(params_hospital)
      redirect_to hospitals_path, notice: "#{@hospital.name} updated successfully"
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
