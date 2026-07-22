class DashboardController < ApplicationController
  TABS = %w[hospitals doctors patients].freeze

  def show
    @tab = TABS.include?(params[:tab]) ? params[:tab] : "hospitals"

    case  @tab
    when "hospitals" then @hospitals = Hospital.all
    when "doctors" then @doctors = Doctor.all
    when "patients" then @patients = Patient.all
    end
  end
end
