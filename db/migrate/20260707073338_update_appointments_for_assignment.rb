class UpdateAppointmentsForAssignment < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :status, :string, default: "pending", null: false
    add_column :appointments, :scheduled_at, :datetime
    rename_column :appointments, :reason, :notes
    remove_column :appointments, :appointment_date, :date
  end
end
