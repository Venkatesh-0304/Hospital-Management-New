class AddColumnDateOfBirthToPatient < ActiveRecord::Migration[8.1]
  def change
    add_column :patients, :born_on, :date
  end
end
