class Admin::HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end
end
