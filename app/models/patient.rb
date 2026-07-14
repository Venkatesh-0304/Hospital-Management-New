class Patient < ApplicationRecord
  validates :name, :age, presence: true
  has_many :appointments
end
