class HospitalMailer < ApplicationMailer
  def details_updated(old_hospital, hospital)
    @old_hospital = old_hospital
    @hospital = hospital
    mail(to: @hospital.admin_email, subject: "Hospital details update")
  end
end
