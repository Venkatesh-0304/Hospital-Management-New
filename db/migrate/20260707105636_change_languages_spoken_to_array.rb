class ChangeLanguagesSpokenToArray < ActiveRecord::Migration[8.1]
    def up
      change_column :profiles, :languages_spoken, :string, array: true, default: [], using: "(string_to_array(languages_spoken, ','))"
    end

    def down
      change_column :profiles, :languages_spoken, :string, array: false, default: nil, using: "array_to_string(languages_spoken, ',')"
    end
end
