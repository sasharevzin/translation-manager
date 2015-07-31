class AddUniqueIndexToSourceTextLanguage < ActiveRecord::Migration
  def change
    add_index :sources, [:language, :text], unique: true, length: { text: 100 }
  end
end
