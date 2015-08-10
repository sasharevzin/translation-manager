class AddUniqueIndexToSourceTextLanguage < ActiveRecord::Migration
  def change
    add_index :sources, [:language, :text], unique: true, length: { text: 255 }
  end
end
