class AddIndexToTextTranslations < ActiveRecord::Migration
  def change
    add_index :translations, :text, length: 100
  end
end
