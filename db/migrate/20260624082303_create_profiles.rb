class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.integer :experience
      t.string :consultation_fee

      t.timestamps
    end
  end
end
