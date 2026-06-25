class Doctor < ApplicationRecord
  validates :name, presence: true
  belongs_to :hospital
  has_one :profile
end
