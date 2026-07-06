class PatientsStatisticsComponent < ViewComponent::Base
  def initialize(patients:)
    @patients = patients
  end

  def total_patients
    @patients.count
  end

  def total_male_Patients
    @patients.where(gender: "male").count
  end

  def total_female_Patients
    @patients.where(gender: "female").count
  end
end
