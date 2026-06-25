class AddDoctorRefToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_reference :profiles, :doctor, null: false, foreign_key: true
  end
end
