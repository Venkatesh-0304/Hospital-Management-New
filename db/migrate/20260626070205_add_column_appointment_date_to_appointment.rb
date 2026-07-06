class AddColumnAppointmentDateToAppointment < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :appointment_date, :date
  end
end
