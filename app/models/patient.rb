class Patient < ApplicationRecord
  validates :name, :age, presence: true
end
