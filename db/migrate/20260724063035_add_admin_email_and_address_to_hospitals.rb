class AddAdminEmailAndAddressToHospitals < ActiveRecord::Migration[8.1]
  def change
    add_column :hospitals, :admin_email, :string, null: false, default: ""
    add_column :hospitals, :address, :string
  end
end
