class Hospital < ApplicationRecord
  has_many :doctors, dependent: :destroy
  validates :name, presence: true
  validates :admin_email, presence: true
end
