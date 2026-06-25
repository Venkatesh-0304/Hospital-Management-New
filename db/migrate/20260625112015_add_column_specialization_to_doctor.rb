class AddColumnSpecializationToDoctor < ActiveRecord::Migration[8.1]
  def change
    add_column :doctors, :specialization, :string
  end
end
