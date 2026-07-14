class Doctor < ApplicationRecord
  validates :name, presence: true
  belongs_to :hospital
  has_one :profile
  accepts_nested_attributes_for :profile
end
