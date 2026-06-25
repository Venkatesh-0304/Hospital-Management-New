class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :reason, presence: true
end
