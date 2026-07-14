class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :notes, presence: true
end
