class DashboardController < ApplicationController
  TABS = %w[hospitals doctors patients].freez

  def show
    @tab = TABS.include?(param[:tab]) ? param[:tab] : "hospitals"

    case  @tab
    when "hospitals" then @hospitals = Hospital.all
    when "doctors" then @doctors = Doctor.all
    when "patients" then @patients = Patient.all
    end
  end
end
