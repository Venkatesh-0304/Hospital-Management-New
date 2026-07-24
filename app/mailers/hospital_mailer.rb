class HospitalMailer < ApplicationMailer
  def details_updated(hospital)
    @hospital = hospital
    mail(to: @hospital.admin_email, subject: "Hospital details update")
  end
end
