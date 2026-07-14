class AddLanguagesSpokenToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :languages_spoken, :string
  end
end
