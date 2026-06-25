class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.text :reason

      t.timestamps
    end
  end
end
