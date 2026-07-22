class Doctor < ApplicationRecord
  validates :name, presence: true
  belongs_to :hospital
  has_one :profile, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments
  accepts_nested_attributes_for :profile
end
